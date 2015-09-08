module Quby
  module Questionnaires
    module Entities
      module Questions
        class CheckboxQuestion < Question
          # checkbox option that checks all other options on check
          attr_accessor :check_all_option

          # checkbox option that unchecks all other options on check
          attr_accessor :uncheck_all_option

          # checkbox option that allows to select a maximum amount of checkboxes
          attr_accessor :maximum_checked_allowed

          # checkbox option that forces to select a minimum amount of checkboxes
          attr_accessor :minimum_checked_required

          def initialize(key, options = {})
            super

            @check_all_option         = options[:check_all_option]
            @uncheck_all_option       = options[:uncheck_all_option]
            @maximum_checked_allowed  = options[:maximum_checked_allowed]
            @minimum_checked_required = options[:minimum_checked_required]

            if @check_all_option
              @validations << {type: :not_all_checked,
                               check_all_key: @check_all_option,
                               explanation: options[:error_explanation]}
            end

            if @uncheck_all_option
              @validations << {type: :too_many_checked,
                               uncheck_all_key: @uncheck_all_option,
                               explanation: options[:error_explanation]}
            end

            if @maximum_checked_allowed
              @validations << {type: :maximum_checked_allowed,
                               maximum_checked_value: @maximum_checked_allowed,
                               explanation: options[:error_explanation]}
            end

            if @minimum_checked_required
              @validations << {type: :minimum_checked_required,
                               minimum_checked_value: @minimum_checked_required,
                               explanation: options[:error_explanation]}
            end
          end

          def claimed_keys
            [key]
          end

          def answer_keys
            # Some options don't have a key (inner_title), they are stripped.
            options.map { |opt| opt.input_key }.compact
          end

          def as_json(options = {})
            super.merge(options: @options.as_json)
          end

          def to_codebook(questionnaire, opts = {})
            options.map do |option|
              option.to_codebook(questionnaire, opts)
            end.compact.join("\n\n")
          end
        end
      end
    end
  end
end
