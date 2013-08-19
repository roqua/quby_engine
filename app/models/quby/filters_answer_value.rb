module Quby
  class FiltersAnswerValue
    def initialize(questionnaire)
      @questionnaire = questionnaire
    end

    def filter(attributes)
      attributes.keep_if do |key, value|
        valid_attribute_keys.include? key
      end
    end

    private

    def valid_attribute_keys
      @valid_attribute_keys ||= @questionnaire.questions.compact.map(&:key).map(&:to_s) +
          @questionnaire.questions.select{|question| question.type == :check_box}.map(&:options).flatten.map(&:key).map(&:to_s) +
          ["activity_log", "aborted"]
    end
  end
end