require 'active_model'
require 'quby/settings'

require 'action_view'
include ActionView::Helpers::SanitizeHelper

module Quby
  module Questionnaires
    module Entities
      class Questionnaire
        extend  ActiveModel::Naming
        include ActiveModel::Validations

        class ValidationError < StandardError; end
        class UnknownInputKey < ValidationError; end

        VALID_LICENSES = [:unknown,
                          :free,               # freely available without license costs,
                          :pay_per_completion, # costs associated with each completed questionnaire,
                          :private]            # not a publicly available questionnaire

        def initialize(key, last_update: Time.now)
          @key = key
          @last_update = Time.at(last_update.to_i)
          @score_calculations ||= {}
          @charts = Charting::Charts.new
          @question_hash ||= {}
          @license = :unknown
          @renderer_version = :v1
          @extra_css = ""
          @panels = []
        end

        attr_accessor :key
        attr_accessor :title
        attr_accessor :description
        attr_accessor :outcome_description
        attr_accessor :short_description
        attr_accessor :abortable
        attr_accessor :enable_previous_questionnaire_button
        attr_accessor :panels
        attr_accessor :score_calculations
        attr_accessor :default_answer_value
        attr_accessor :renderer_version
        attr_accessor :leave_page_alert
        attr_accessor :question_hash
        attr_accessor :extra_css
        attr_accessor :license

        attr_accessor :last_author
        attr_accessor :allow_hotkeys # allow hotkeys for :all views, just :bulk views (default), or :none for never
        attr_accessor :last_update

        attr_accessor :charts

        def leave_page_alert
          return nil unless Settings.enable_leave_page_alert
          @leave_page_alert || "Als u de pagina verlaat worden uw antwoorden niet opgeslagen."
        end

        def allow_hotkeys
          (@allow_hotkeys || :bulk).to_s
        end

        def to_param
          key
        end

        def add_panel(panel)
          @panels << panel
        end

        def callback_after_dsl_enhance_on_questions
          @question_hash.values.each do |q|
            q.run_callbacks :after_dsl_enhance
          end
        end

        def validate_questions
          @question_hash.values.each do |q|
            unless q.valid?
              q.errors.each { |attr, err| errors.add(attr, err) }
            end
          end
        end

        # Given a list of question and option keys returns a list of input-keys.
        # If a given key is a question-key, adds the question.input_keys
        # If a given key is an option-input-key it adds the given key.
        # Raises an error if a key is not defined.
        def expand_input_keys(keys)
          all_keys = input_keys
          keys.reduce([]) do |ikeys, key|
            if question_hash[key]
              ikeys += question_hash[key].input_keys
            elsif all_keys.include? key
              ikeys << key
            else
              fail UnknownInputKey, "Unknown input key #{key}"
            end
          end
        end

        # Returns all question and options keys.
        def input_keys
          question_hash.values.map { |q| q.input_keys }.flatten
        end

        # Returns all possible answer keys.
        # Difference with input_keys is radio-inputs being answers of the question-key.
        def answer_keys
          question_hash.values.map { |q| q.answer_keys }.flatten
        end

        def questions_tree
          return @questions_tree_cache if @questions_tree_cache

          recurse = lambda do |question|
            [question, question.subquestions.map(&recurse)]
          end

          @questions_tree_cache = (@panels && @panels.map do |panel|
            panel.items.map { |item| recurse.call(item) if item.is_a?(Quby::Questionnaires::Entities::Items::Question) }
          end)
        end

        def questions
          @questions_cache ||= (questions_tree.flatten rescue [])
        end

        def questions_of_type(type)
          questions.compact.select { |question| question.type == type }
        end

        def license=(type)
          fail ArgumentError, 'Invalid license' unless VALID_LICENSES.include?(type)
          @license = type
        end

        def as_json(options = {})
          {
            key: key,
            title: title,
            description: description,
            outcome_description: outcome_description,
            short_description: short_description,
            panels: panels
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

          top_questions = panels.map do |panel|
            panel.items.select { |item| item.is_a? Items::Question }
          end.flatten.compact

          top_questions.each do |question|
            output << question.to_codebook(self, options)
            output << ""
          end

          output = output.join("\n")
          strip_tags(output).gsub("&lt;", "<")
        end

        def key_in_use?(key)
          question_hash.key?(key)  ||
          score_calculations.key?(key) ||
          input_keys.include?(key)
        end

        def add_score_calculation(builder)
          score_calculations[builder.key] = builder
        end

        def scores
          score_calculations.values.select(&:score)
        end

        def find_plottable(key)
          score_calculations[key] || question_hash.with_indifferent_access[key]
        end

        def actions
          score_calculations.values.select(&:action)
        end

        def completion
          score_calculations.values.select(&:completion).first
        end

        def add_chart(chart)
          charts.add chart
        end
      end
    end
  end
end
