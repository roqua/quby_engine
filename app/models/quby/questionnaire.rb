include ActionView::Helpers::SanitizeHelper

module Quby
  class Questionnaire # < ActiveRecord::Base
    extend  ActiveModel::Naming
    include ActiveModel::Validations

    class RecordNotFound < StandardError; end
    class ValidationError < StandardError; end

    def self.questionnaire_finder
      Quby.questionnaire_finder
    end

    def self.all
      questionnaire_finder.all
    end

    def self.find_by_key(key)
      questionnaire_finder.find(key)
    end

    def self.exists?(key)
      questionnaire_finder.exists?(key)
    end

    # Faux has_many :answers
    def answers
      Quby::Answer.where(:questionnaire_key => self.key)
    end

    def initialize(key, definition = nil, last_update = Time.now)
      @key = key
      @definition = definition if definition
      @last_update = Time.at(last_update.to_i)
      @score_builders ||= {}
      @question_hash ||= {}

      @scroll_to_next_question = false

      enhance_by_dsl
    end

    def path
      self.class.questionnaire_finder.questionnaire_path(key)
    end

    validate do
      errors.add(:key, "Must be present") unless key.present?
      errors.add(:key, "Must be unique") if Quby::Questionnaire.exists?(key) and not persisted?
      errors.add(:key, "De key mag enkel kleine letters, cijfers en underscores bevatten, " +
                 "moet beginnen met een letter en mag hoogstens 10 karakters lang zijn."
                 ) unless key =~ /^[a-z][a-z_0-9]{0,9}$/ or persisted?
    end

    validate :validate_definition_syntax

    def save
      if valid?
        File.open(path, "w") {|f| f.write( self.definition ) }
        @persisted = true
        return true
      else
        return false
      end
    end

    # TODO remove this as it does not do anything
    def save!
      if valid?
        write_to_disk
      else
        raise ValidationError
      end

      true
    end

    # whether the questionnaire was already persisted
    def persisted?
      persisted
    end

    #after_destroy :remove_from_disk
    #after_destroy :remove_answers

    attr_accessor :key
    attr_accessor :title
    attr_accessor :definition
    attr_accessor :description
    attr_accessor :outcome_description
    attr_accessor :short_description
    attr_accessor :abortable
    attr_accessor :enable_previous_questionnaire_button
    attr_accessor :panels
    attr_accessor :score_builders
    attr_accessor :default_answer_value
    attr_accessor :scroll_to_next_question
    attr_accessor :log_user_activity

    attr_accessor :leave_page_alert

    attr_accessor :question_hash

    attr_accessor :extra_css

    attr_accessor :last_author

    #allow hotkeys for either :all views, just :bulk views (default), or :none for never
    attr_accessor :allow_hotkeys
    # flag indicating whether a questionnaire was already persisted
    attr_accessor :persisted

    attr_accessor :last_update

    #default_scope :order => "key ASC"
    #scope :active, where(:active => true)

    def leave_page_alert
      @leave_page_alert || "Als u de pagina verlaat worden uw antwoorden niet opgeslagen."
    end

    def allow_hotkeys
      (@allow_hotkeys || :bulk).to_s
    end

    def to_param
      key
    end

    def enhance_by_dsl
      if self.definition
        @question_hash = {}

        functions = Function.all.map(&:definition).join("\n\n")
        functions_and_definition = [functions, self.definition].join("\n\n")
        begin
          QuestionnaireDsl.enhance(self, functions_and_definition || "")
        rescue SyntaxError => e
          errors.add(:definition, {:message => "Questionnaire error: #{key} <br/> #{e.message}", :backtrace => e.backtrace[0..5].join("<br/>")})
        end
      end
    end

    def get_input_keys(keys)
      input_keys = []
      keys.each do |key|
        if question_hash[key]
          question = question_hash[key]
          if question.options.blank?
            input_keys << key
          else
            question.options.each do |opt|
              if question.type == :check_box
                input_keys << "#{opt.key}"
              else
                input_keys << "#{key}_#{opt.key}"
              end
            end
          end
        else
          input_keys << key
        end
      end
      input_keys
    end

    def questions_tree
      return @questions_tree_cache if @questions_tree_cache

      recurse = lambda do |question|
        [question, question.subquestions.map(&recurse) ]
      end

      @questions_tree_cache = (@panels && @panels.map do |panel|
        panel.items.map {|item| recurse.call(item) if Items::Question === item }
      end)
    end

    def questions
      @questions_cache ||= (questions_tree.flatten rescue [])
    end

    def as_json(options = {})
      {
        :key => self.key,
        :title => self.title,
        :description => self.description,
        :outcome_description => self.outcome_description,
        :short_description => self.short_description,
        :panels => self.panels
      }
    end

    def to_codebook(options = {})
      output = []
      output << title
      output << "Date unknown"
      output << ""

      options[:extra_vars].andand.each do |var|
        output << "#{var[:key]} #{var[:type]}"
        output << "\"#{var[:description]}\""
        output << ""
      end

      questions.compact.each do |question|
        output << question.to_codebook(self, options)
        output << ""
      end

      #scores.andand.each do |score|
      #output << "score #{score.key}"
      #end

      output = output.join("\n")
      strip_tags(output).gsub("&lt;", "<")

    end

    def key_in_use?(key)
      question_hash.with_indifferent_access.key?(key) ||
        score_builders.key?(key)
    end

    def push_score_builder(builder)
      score_builders[builder.key] = builder
    end

    def scores
      score_builders.values.select(&:score)
    end

    def actions
      score_builders.values.select(&:action)
    end

    def completion
      score_builders.values.select(&:completion).first
    end

    protected

    def ensure_linux_line_ends
      @definition = @definition.andand.gsub("\r\n", "\n")
    end

    def require_key
    end

    def validate_definition_syntax
      ensure_linux_line_ends

      q = Quby::Questionnaire.new(self.key)
      q.question_hash = {}

      begin
        functions = Function.all.map(&:definition).join("\n\n")
        QuestionnaireDsl.enhance(q, [functions, self.definition].join("\n\n"))

        #check if to be hidden questions actually exist
        q.questions.compact.each do |question|
          question.options.each do |option|
            if option.hides_questions.present?
              option.hides_questions.each do |key|
                raise "Question #{question.key} option #{option.key} hides nonexistent question #{key}" unless q.question_hash[key]
              end
            end
          end
        end

        #Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
      rescue Exception => e
        errors.add(:definition, {:message => "Questionnaire error: #{key}\n#{e.message}", :backtrace => e.backtrace[0..5].join("<br/>")})
        return false
      end

      enhance_by_dsl
    end

    def write_to_disk

      #unless Rails.env.development?
      #output = `cd #{Quby.questionnaires_path} && git config user.name \"quby #{Rails.root.parent.parent.basename.to_s}, user: #{@last_author}\" && git add . && git commit -m 'auto-commit from admin' && git push`
      #result = $?.success?
      #unless result
      #logger.error "Git add, commit or push failed: #{output}"
      #end
      #end
    end

    def remove_from_disk
      unless Rails.env.test?
        unless Rails.env.development?
          filename = File.join(Quby.questionnaires_path, "#{key}.rb")
          return unless File.exists?(filename)
          #logger.info "Removing #{filename}..."
          output = `cd #{Quby.questionnaires_path} && git config user.name \"quby #{Rails.root.parent.parent.basename.to_s}, user: #{@last_author}\" && git rm #{key}.rb && git commit -m 'removed questionnaire #{key}' && git push`
          result = $?.success?
          unless result
            #logger.error "Git rm, commit or push failed: #{output}"
          end
        end
      end
    end

    #def remove_answers
    #Answer.where(:questionnaire_id => self.id).delete
    #end
  end
end
