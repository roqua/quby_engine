module Quby
  module Answers
    module Services
      class FiltersAnswerValue
        def initialize(questionnaire)
          @questionnaire = questionnaire
        end

        def filter(attributes)
          filtered_attributes = valid_attribute_keys.map do |key|
            [key, attributes[key]]
          end

          Hash[filtered_attributes]
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
