require 'quby/extensions/maruku_extensions'
require 'quby/questionnaires/entities/item'

module Quby
  module Questionnaires
    module Entities
      class Question < Item
        set_callback :after_dsl_enhance, :expand_depends_on_input_keys

        # Standard attributes
        attr_accessor :key
        attr_accessor :questionnaire
        attr_accessor :title
        attr_accessor :context_free_title
        attr_accessor :description

        attr_accessor :labels

        # What kind of question is this?
        attr_accessor :type

        # How should we display this question
        attr_accessor :as

        # To hide old questions
        attr_accessor :hidden

        # In what modes do we display this question
        # NOTE We always display questions in print-view (if they have an answer)
        attr_accessor :display_modes

        # Multiple-choice questions have options to choose from
        attr_accessor :options

        # Question validation fails when there are no title and no context_free_title.
        # When :allow_blank_titles => true passed, validation does not fail. Any other value will raise the failure.
        attr_accessor :allow_blank_titles

        # Minimum and maximum values for float and integer types
        attr_accessor :minimum
        attr_accessor :maximum

        # Whether the browser should autocomplete this question (off by default)
        attr_accessor :autocomplete

        # Whether we show the value for each option
        # :all => in all questionnaire display modes
        # :none => in none of display modes
        # :paged => for only in :paged display mode
        # :bulk => for only in :bulk display mode
        attr_accessor :show_values
        validates :show_values, inclusion: {
          in: [:all, :none, :paged, :bulk, :print],
          message: "option invalid: %{value}. Valid options: :all, :none, :paged, :bulk)" }

        # Structuring
        attr_accessor :validations
        attr_accessor :dependencies

        # To display unit for number items
        attr_accessor :unit
        # To specify size of string/number input boxes
        attr_accessor :size

        # Whether this radio question is deselectable
        attr_accessor :deselectable

        # Some questions are a tree.
        attr_accessor :parent
        attr_accessor :parent_option_key

        # Whether we can collapse this in bulk view
        attr_accessor :disallow_bulk

        # This question should not validate itself unless the depends_on question is answered.
        # May also be an array of "#{question_key}_#{option_key}" strings that specify options
        # this question depends on.
        attr_accessor :depends_on

        # Extra data hash to store on the question item's html element
        attr_accessor :extra_data

        # data-attributes for the input tag.
        attr_accessor :input_data

        # Whether we use the :description, the :value or :none for the score header above this question
        attr_accessor :score_header

        # options for grouping questions and setting a minimum or maximum number of answered questions in the group
        attr_accessor :question_group
        attr_accessor :group_minimum_answered
        attr_accessor :group_maximum_answered
        attr_accessor :group_require_all_or_none

        # Text variable name that will be replaced with the answer to this question
        # In all following text elements that support markdown
        attr_accessor :sets_textvar

        # Amount of rows and cols a textarea has
        attr_accessor :lines
        attr_accessor :cols

        # Table this question might belong to
        attr_accessor :table

        # In case of being displayed inside a table, amount of columns/rows to span
        attr_accessor :col_span
        attr_accessor :row_span

        attr_accessor :default_invisible

        # Slider only: where to place the sliding thing by default
        # Can have value :hidden for a hidden handle.
        attr_accessor :default_position

        ##########################################################

        # rubocop:disable CyclomaticComplexity
        def initialize(key, options = {})
          super(options)
          @extra_data ||= {}
          @options = []
          @questionnaire = options[:questionnaire]
          @key = key
          @type = options[:type]
          @as = options[:as]
          @title = options[:title]
          @context_free_title = options[:context_free_title]
          @allow_blank_titles = options[:allow_blank_titles]
          @description = options[:description]
          @display_modes = options[:display_modes]
          @presentation = options[:presentation]
          @validations = []
          @parent = options[:parent]
          @hidden = options[:hidden]
          @table = options[:table]
          @parent_option_key = options[:parent_option_key]
          @autocomplete = options[:autocomplete] || "off"
          @show_values = options[:show_values] || :bulk
          @deselectable = options[:deselectable] || false
          @disallow_bulk = options[:disallow_bulk]
          @score_header = options[:score_header] || :none
          @sets_textvar = "#{questionnaire.key}_#{options[:sets_textvar]}" if options[:sets_textvar]
          @unit = options[:unit]
          @lines = options[:lines] || 6
          @cols = options[:cols] || 40
          @default_invisible = options[:default_invisible] || false
          @labels ||= []

          @col_span = options[:col_span] || 1
          @row_span = options[:row_span] || 1

          set_depends_on(options[:depends_on])

          @question_group = options[:question_group]
          @group_minimum_answered = options[:group_minimum_answered]
          @group_maximum_answered = options[:group_maximum_answered]
          @group_require_all_or_none = options[:group_require_all_or_none]

          @input_data = {}
          @input_data[:value_tooltip] = true if options[:value_tooltip]

          # Require subquestions of required questions by default
          options[:required] = true if @parent.andand.validations.andand.first.andand[:type] == :requires_answer
          @validations << {type: :requires_answer, explanation: options[:error_explanation]} if options[:required]

          if @type == :float
            @validations << {type: :valid_float, explanation: options[:error_explanation]}
          elsif @type == :integer
            @validations << {type: :valid_integer, explanation: options[:error_explanation]}
          elsif @type == :date
            @validations << {type: :regexp, matcher: /(0?[1-9]|[1-2][0-9]|3[01])-(0?[1-9]|1[012])-(19|20)\d\d/,
                             explanation: (options[:error_explanation] || "Voer een geldige datum in (DD-MM-JJJJ).")}
          end

          if options[:minimum] and (@type == :integer || @type == :float)
            @validations << {type: :minimum, value: options[:minimum], explanation: options[:error_explanation]}
          end
          if options[:maximum] and (@type == :integer || @type == :float)
            @validations << {type: :maximum, value: options[:maximum], explanation: options[:error_explanation]}
          end
          @default_position = options[:default_position]

          if @question_group
            if @group_minimum_answered
              @validations << {type: :answer_group_minimum, group: @question_group, value: @group_minimum_answered,
                               explanation: options[:error_explanation]}
            end
            if @group_maximum_answered
              @validations << {type: :answer_group_maximum, group: @question_group, value: @group_maximum_answered,
                               explanation: options[:error_explanation]}
            end
            if @group_require_all_or_none
              @validations << {type: :answer_group_require_all_or_none, group: @question_group,
                               explanation: options[:error_explanation]}
            end
          end
        end
        # rubocop:enable CyclomaticComplexity

        # rubocop:disable AccessorMethodName
        def set_depends_on(keys)
          return if keys.blank?
          keys = [keys] unless keys.is_a?(Array)
          @depends_on = keys
        end
        # rubocop:enable AccessorMethodName

        def context_free_title
          @context_free_title || @title
        end

        def expand_depends_on_input_keys
          return unless @depends_on
          @depends_on = questionnaire.expand_input_keys(@depends_on)
          @extra_data[:"depends-on"] = @depends_on.to_json
        rescue => e
          raise e.class, "Question #{key} depends_on contains an error: #{e.message}"
        end

        def col_span
          options.length > 0 && type != :select ? options.length : @col_span
        end

        def as_json(options = {})
          # rubocop:disable SymbolName
          super.merge(
            key: key,
            title: title,
            description: description,
            type: type,
            validations: validations,
            unit: unit,
            hidden: hidden?,
            display_modes: display_modes,
            default_invisible: default_invisible,
            viewSelector: view_selector,
            parentKey: parent.andand.key,
            parentOptionKey: parent_option_key,
            deselectable: deselectable
          )
        end

        # Returns all keys belonging to html inputs generated by this question.
        def input_keys
          if options.blank?
            answer_keys
          else
            # Some options don't have a key (inner_title), they are stripped
            options.map { |opt| opt.input_key }.compact
          end
        end

        def key_in_use?(k)
          claimed_keys.include?(k) ||
          options.any? { |option| option.key_in_use?(k) }
        end

        # The keys this question claims as his own. Not including options and subquestions.
        # Includes keys for the question, inputs and answers.
        def claimed_keys
          [key]
        end

        # Returns all possible answer keys of this question (excluding subquestions, including options).
        # radio/select/scale-options do not create answer_keys, but answer values.
        def answer_keys
          [key]
        end

        def default_position
          half = (type == :float) ? 2.0 : 2
          @default_position || ((minimum + maximum) / half if minimum && maximum)
        end

        def minimum
          validations.find { |i| i[:type] == :minimum }.try(:fetch, :value)
        end

        def maximum
          validations.find { |i| i[:type] == :maximum }.try(:fetch, :value)
        end

        def html_id
          "answer_#{key}_input"
        end

        def view_selector
          table.blank? ? "#item_#{key}" : "[data-for=#{key}], #answer_#{key}_input"
        end

        def hidden?
          hidden
        end

        def show_values_in_mode?(mode)
          case show_values
          when :none then false
          when :all then true
          else show_values == mode
          end
        end

        def subquestions
          options.map { |opt| opt.questions }.flatten
        end

        def subquestion?
          !parent_option_key.nil?
        end

        def to_codebook(questionnaire, opts = {})
          output = []
          question_key = codebook_key(key, questionnaire, opts)
          output << "#{question_key} #{codebook_output_type} #{codebook_output_range}#{' deprecated' if hidden}"
          output << "\"#{title}\"" unless title.blank?
          options_string = options.map do |option|
            option.to_codebook(questionnaire, opts)
          end.compact.join("\n")
          output << options_string unless options.blank?
          output.join("\n")
        end

        def codebook_key(key, questionnaire, opts = {})
          key.to_s.gsub(/^v_/, "#{opts[:roqua_key] || questionnaire.key.to_s}_")
        end

        def codebook_output_type
          type
        end

        def codebook_output_range
          range_min = validations.find { |i| i[:type] == :minimum }.andand[:value]
          range_max = validations.find { |i| i[:type] == :maximum }.andand[:value]

          if range_min || range_max
            "(#{[range_min, "value", range_max].compact.join(" &lt;= ")})"
          else
            ""
          end
        end
      end
    end
  end
end

require 'quby/questionnaires/entities/questions/checkbox_question'
require 'quby/questionnaires/entities/questions/date_question'
require 'quby/questionnaires/entities/questions/deprecated_question'
require 'quby/questionnaires/entities/questions/float_question'
require 'quby/questionnaires/entities/questions/integer_question'
require 'quby/questionnaires/entities/questions/radio_question'
require 'quby/questionnaires/entities/questions/select_question'
require 'quby/questionnaires/entities/questions/string_question'
require 'quby/questionnaires/entities/questions/text_question'
