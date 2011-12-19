module Quby
  class Questionnaire # < ActiveRecord::Base
    class RecordNotFound < StandardError; end

    def self.all
      Dir[File.join(Quby.questionnaires_path, "*.rb")].map do |filename|
        key = File.basename(filename, '.rb')
        self.new(key)
      end
    end

    # Faux has_many :answers
    def answers
      Quby::Answer.where(:questionnaire_key => self.key)
    end

    def self.find_by_key(key)
      path = File.join(Quby.questionnaires_path, "#{key}.rb")
      if File.exist?(path)
        self.new(key)
      else
        raise RecordNotFound, path
      end
    end

    def initialize(key)
      self.key = key
      enhance_by_dsl
    end

    #after_initialize :enhance_by_dsl

    #before_validation :ensure_linux_line_ends
    #before_save :validate_definition_syntax
    #after_save  :write_to_disk
    #after_destroy :remove_from_disk
    #after_destroy :remove_answers

    attr_accessor :key
    attr_accessor :title
    attr_accessor :description
    attr_accessor :outcome_description
    attr_accessor :short_description
    attr_accessor :abortable
    attr_accessor :enable_previous_questionnaire_button
    attr_accessor :panels
    attr_accessor :scores
    attr_accessor :default_answer_value

    attr_accessor :leave_page_alert

    attr_accessor :question_hash

    attr_accessor :extra_css

    attr_accessor :last_author

    #allow hotkeys for either :all views, just :bulk views (default), or :none for never
    attr_accessor :allow_hotkeys

    #default_scope :order => "key ASC"
    #scope :active, where(:active => true)

    #validates_presence_of :key
    #validates_uniqueness_of :key
    #validates_format_of :key,
      #:with => /^[a-z][a-z_0-9]*$/,
      #:message => "De key mag enkel kleine letters, cijfers en underscores bevatten en moet beginnen met een letter.",
      #:on => :create

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
        QuestionnaireDsl.enhance(self, functions_and_definition || "")
      end
    end

    def definition
      @definition ||= File.read(File.join(Quby.questionnaires_path, "#{key}.rb")) rescue nil
    end

    def definition=(value)
      @definition = value.gsub("\r\n", "\n")
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
      recurse = lambda do |question|
        [question, question.subquestions.map(&recurse) ]
      end

      @panels && @panels.map do |panel|
        panel.items.map {|item| recurse.call(item) if Items::Question === item }
      end
    end

    def questions
      tree = questions_tree
      questions_tree.flatten rescue []
    end

    def as_json(options = {})
      attributes.merge({
        :key => self.key,
        :title => self.title,
        :description => self.description,
        :outcome_description => self.outcome_description,
        :short_description => self.short_description,
        :panels => self.panels
      })
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

      output.join("\n")
    end

    protected

    #def ensure_linux_line_ends
      #self.definition = self.definition.gsub("\r\n", "\n")
    #end

    #def validate_definition_syntax
      #q = Questionnaire.new
      #q.question_hash = {}
      #begin
        #functions = Function.all.map(&:definition).join("\n\n")
        #QuestionnaireDsl.enhance(q, [functions, self.definition].join("\n\n"))
        ##Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
      #rescue Exception => e
        #errors.add(:definition, "Error")
        #errors.add(:definition, e.message)
        #errors.add(:definition, e.backtrace[0..5].join("<br/>"))
        #return false
      #end
      #return true
    #end

    #def write_to_disk
      #filename = File.join(Quby.questionnaires_path, "#{key}.rb")
      #logger.info "Writing #{filename}..."
      #unless Rails.env.test?
        #File.open(filename, "w") {|f| f.write( self.definition ) }

        #unless Rails.env.development?
          #output = `cd #{Quby.questionnaires_path} && git config user.name \"quby #{Rails.root.parent.parent.basename.to_s}, user: #{@last_author}\" && git add . && git commit -m 'auto-commit from admin' && git push`
          #result = $?.success?
          #unless result
            #logger.error "Git add, commit or push failed: #{output}"
          #end
        #end
      #end
    #end

    #def remove_from_disk
      #unless Rails.env.test?
        #unless Rails.env.development?
          #filename = File.join(Quby.questionnaires_path, "#{key}.rb")
          #return unless File.exists?(filename)
          #logger.info "Removing #{filename}..."
          #output = `cd #{Quby.questionnaires_path} && git config user.name \"quby #{Rails.root.parent.parent.basename.to_s}, user: #{@last_author}\" && git rm #{key}.rb && git commit -m 'removed questionnaire #{key}' && git push`
          #result = $?.success?
          #unless result
            #logger.error "Git rm, commit or push failed: #{output}"
          #end
        #end
      #end
    #end

    #def remove_answers
      #Answer.where(:questionnaire_id => self.id).delete
    #end
  end
end
