module Quby
  class AttributeCalculator
    attr_reader :questionnaire, :answer
    attr_reader :hidden, :shown, :groups

    def initialize(questionnaire, answer)
      @questionnaire = questionnaire
      @answer = answer
      @hidden = []
      @shown  = []
      @groups = {}

      questionnaire.questions.compact.each { |question| process_question(question) }
    end

    def process_question(question)
      return if question.hidden?

      process_questions_that_are_invisible_by_default(question)
      process_showing_and_hiding(question)
      process_question_groups(question)
    end

    def process_questions_that_are_invisible_by_default(question)
      if question.default_invisible && !@shown.include?(question.key)
        @hidden.push question.key
      end
    end

    def process_showing_and_hiding(question)
      case question.type
      when :radio, :scale, :select
        process_radioish(question)
      when :check_box
        process_checkbox(question)
      else
        # nothing
      end
    end

    def process_question_groups(question)
      if question.question_group
        @groups[question.question_group] = [] unless @groups[question.question_group]
        @groups[question.question_group] << question.key
      end
    end

    def process_radioish(question)
      if value = answer.send(question.key)
        selected_option = question.options.find { |option| option.key.to_s == value }

        if selected_option
          process_option_hiding(selected_option)
          process_option_showing(selected_option)
        end
      end
    end

    def process_checkbox(question)
      selected_options = question.options.select { |option| !option.inner_title? && answer.send(option.key) == 1 }
      selected_options.each do |option|
        process_option_hiding(option)
        process_option_showing(option)
      end
    end

    def process_option_hiding(option)
      if option.hides_questions.present?
        @hidden.concat(option.hides_questions.reject { |key| @shown.include? key }).uniq
      end
    end

    def process_option_showing(option)
      if option.shows_questions.present?
        @hidden.delete_if { |key| option.shows_questions.include? key }
        @shown.concat(option.shows_questions).uniq
      end
    end
  end
end
