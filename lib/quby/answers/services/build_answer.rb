# frozen_string_literal: true

module Quby
  module Answers
    module Services
      class BuildAnswer
        attr_reader :questionnaire
        attr_reader :given_attributes

        def initialize(questionnaire, given_attributes)
          @questionnaire = questionnaire
          @given_attributes = given_attributes.with_indifferent_access
        end

        def build
          Quby::Answers::Entities::Answer.new(attributes)
        end

        private

        def attributes
          {
            questionnaire_key:    questionnaire.key,
            questionnaire:        @questionnaire,
            token:                SecureRandom.hex(8),
            dsl_last_update:      questionnaire.last_update,
            raw_params:           given_attributes.fetch(:raw_params,           {}),
            import_notes:         given_attributes.fetch(:import_notes,         {}),
            patient:              given_attributes.fetch(:patient,              {}),
            test:                 given_attributes.fetch(:test,                 false),
            outcome_generated_at: given_attributes.fetch(:outcome_generated_at, nil),
            scores:               given_attributes.fetch(:scores,               {}),
            actions:              given_attributes.fetch(:actions,              {}),
            completion:           given_attributes.fetch(:completion,           {}),
            started_at:           given_attributes.fetch(:started_at, nil),
            completed_at:         given_attributes.fetch(:completed_at,         nil),
            flags:                calculate_flags,
            textvars:             calculate_textvars,
            value:                calculate_value
          }
        end

        def calculate_value
          quest_value = questionnaire.default_answer_value || {}
          given_value = given_attributes[:value] || {}

          quest_value.merge(given_value).stringify_keys
        end

        def calculate_flags
          flags = given_attributes.fetch(:flags, {})
          questionnaire.filter_flags(flags)
        end

        def calculate_textvars
          given    = questionnaire.filter_textvars(given_attributes.fetch(:textvars, {}))
          defaults = questionnaire.default_textvars
          textvars = defaults.merge(given)

          textvars
        end
      end
    end
  end
end
