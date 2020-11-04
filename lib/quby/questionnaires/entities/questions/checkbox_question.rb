# frozen_string_literal: true

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
          end

          def variable_descriptions
            options.each_with_object(key => context_free_title) do |option, hash|
              next if option.input_key.blank?
              hash[option.input_key] = "#{context_free_title} - #{option.description}"
            end.with_indifferent_access
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
