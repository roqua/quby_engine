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
      return @valid_attribute_keys if @valid_attribute_keys

      @valid_attribute_keys = %w(activity_log aborted)
      @valid_attribute_keys += @questionnaire.questions.compact.map(&:key).map(&:to_s)
      @valid_attribute_keys += check_box_questions.map(&:options).flatten.map(&:key).map(&:to_s)
      @valid_attribute_keys += date_questions.map { |q| [q.year_key, q.month_key, q.day_key] }.flatten.map(&:to_s)
      @valid_attribute_keys
    end

    def check_box_questions
      @questionnaire.questions_of_type :check_box
    end

    def date_questions
      @questionnaire.questions_of_type :date
    end
  end
end