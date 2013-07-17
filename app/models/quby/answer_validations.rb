module Quby
  module AnswerValidations
    def cleanup_input
      questionnaire.questions.each do |question|
        next unless question
        next if question.hidden?

        answer = self.send(question.key)

        if answer
          if answer == "DESELECTED_RADIO_VALUE" or
             answer == question.extra_data[:placeholder].to_s or
              (question.parent and question.parent_option_key and
              ((question.parent.type == :radio     and
                  value[question.parent.key.to_s] != question.parent_option_key.to_s) or
                (question.parent.type == :check_box and
                  value[question.parent.key.to_s].andand[question.parent_option_key.to_s] != 1))) or
             hidden_questions.andand.include?(question.key)
            clear_question(question)
          end
        end
      end
    end

    def clear_question(question)
      value.delete(question.key.to_s)
      if question.type == :check_box
        question.options.each do |opt|
          value.delete(opt.key.to_s)
        end
      end
    end

    def calculate_attributes
      if @hidden_questions == nil
        @hidden_questions = []
        @shown_questions = []
        @question_groups = {}

        questionnaire.questions.each do |question|
          next unless question
          next if question.hidden?

          answer = self.send(question.key)

          if question.default_invisible && !@shown_questions.include?(question.key)
            @hidden_questions.push question.key
          end

          if answer and [:radio, :scale].include?(question.type)
            question.options.each do |opt|
              if answer.to_sym == opt.key
                if opt.hides_questions.present?
                  @hidden_questions.concat(opt.hides_questions.reject{|key| @shown_questions.include? key}).uniq
                end
                if opt.shows_questions.present?
                  @hidden_questions.delete_if{|key| opt.shows_questions.include? key}
                  @shown_questions.concat(opt.shows_questions).uniq
                end
              end
            end
          end

          if question.question_group
            @question_groups[question.question_group] = [] unless @question_groups[question.question_group]
            @question_groups[question.question_group] << question.key
          end
        end
      end
    end

    def hidden_questions
      calculate_attributes
      @hidden_questions
    end
    def shown_questions
      calculate_attributes
      @shown_questions
    end
    def question_groups
      calculate_attributes
      @question_groups
    end

    def validate_answers
      questionnaire.questions.each do |question|
        next unless question
        next if question.hidden?

        if question.depends_on.present?
          next unless question.depends_on.any? {|key| self.send(key) }
        end

        answer = self.send(question.key)
        question.validations.each do |validation|
          case validation[:type]
          when :valid_integer
            next if answer.blank?
            begin
              Integer(answer)
            rescue ArgumentError
              add_error(question, :valid_integer, validation[:message] || "Invalid integer")
            end
          when :valid_float
            next if answer.blank?
            begin
              Float(answer)
            rescue ArgumentError
              add_error(question, :valid_float, validation[:message] || "Invalid float")
            end
          when :regexp
            next if answer.blank?
            match = validation[:matcher].match(answer)
            add_error(question, validation[:type], validation[:message] || "Does not match pattern expected.") if not match or match[0] != answer
          when :requires_answer
            next if (hidden_questions.include?(question.key) or @aborted)
            if question.type == :check_box
              add_error(question, validation[:type], validation[:message] || "Must be answered.") if answer.values.reduce(:+) == 0
            else
              add_error(question, validation[:type], validation[:message] || "Must be answered.") if answer.blank?
            end
          when :minimum
            add_error(question, validation[:type], validation[:message] || "Smaller than minimum") if not answer.blank? and answer.to_f < validation[:value]
          when :maximum
            add_error(question, validation[:type], validation[:message] || "Exceeds maximum") if not answer.blank? and answer.to_f > validation[:value]
          when :too_many_checked
            if self.send(question.uncheck_all_option) == 1 and answer.values.reduce(:+) > 1
              add_error(question, :too_many_checked, validation[:message] || "Invalid combination of options.")
            end
          when :not_all_checked
            if self.send(question.check_all_option) == 1 and answer.values.reduce(:+) < answer.length - (question.uncheck_all_option ? 1 : 0)
              add_error(question, :not_all_checked, validation[:message] || "Invalid combination of options.")
            end
          when :answer_group_minimum
            next if @aborted
            answered = calc_answered(question_groups[validation[:group]])
            if answered < validation[:value]
              add_error(question, :answer_group_minimum, validation[:message] || "Needs at least #{validation[:value]} question(s) answered.")
            end
          when :answer_group_maximum
            answered = calc_answered(question_groups[validation[:group]])
            if answered > validation[:value]
              add_error(question, :answer_group_maximum, validation[:message] || "Needs at most #{validation[:value]} question(s) answered.")
            end
          end
        end
      end
    end
  end
end