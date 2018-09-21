# frozen_string_literal: true

module Quby
  module Answers
    module Services
      class FiltersAnswerValue
        def initialize(questionnaire)
          @questionnaire = questionnaire
        end

        def filter(attributes)
          valid_attribute_keys.each_with_object({}) do |key, obj|
            obj[key] = attributes.fetch(key, nil)
          end
        end

        private

        def valid_attribute_keys
          @valid_attribute_keys ||= %w(aborted) +
              @questionnaire.answer_keys.map(&:to_s)
        end
      end
    end
  end
end
