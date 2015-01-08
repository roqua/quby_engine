module Quby
  module Answers
    module Services
      class AttributeCalculator
        attr_reader :questionnaire, :answer
        attr_reader :hidden, :shown, :groups

        # To check if a question or question option that is depended on is filled in,
        # we can look up the question that fits the key in the depends_on_lookup hash.
        attr_reader :depends_on_lookup

        def initialize(questionnaire, answer)
          @questionnaire = questionnaire
          @answer = answer
          @hidden = [] # does not include hidden questions that are shown
          @shown  = []
          @groups = {}
          @depends_on_lookup = {}

          init_flag_result
          questionnaire.questions.compact.each { |question| process_question(question) }
        end

        def init_flag_result
          questionnaire.flags.each do |_flag_key, flag|
            flag.if_triggered_by answer.flags do
              flag.hides_questions.each do |question_key|
                @hidden.push question_key unless @shown.include?(question_key)
              end
              flag.shows_questions.each do |question_key|
                @shown.push question_key
              end
            end
          end
        end

        def process_question(question)
          return if question.hidden?

          process_questions_that_are_invisible_by_default(question)
          process_question_answer(question)
          process_question_groups(question)
        end

        def process_questions_that_are_invisible_by_default(question)
          if question.default_invisible && !@shown.include?(question.key)
            @hidden.push question.key
          end
        end

        def process_question_answer(question)
          case question.type
          when :radio, :scale, :select
            process_radioish(question)
          when :check_box
            process_checkbox(question)
          else
            if answer.send(question.key).present?
              @depends_on_lookup[question.key] = true
            end
          end
        end

        def process_question_groups(question)
          if question.question_group
            @groups[question.question_group] = [] unless @groups[question.question_group]
            @groups[question.question_group] << question.key unless @hidden.include?(question.key)
          end
        end

        def process_radioish(question)
          if value = answer.send(question.key)
            selected_option = question.options.find { |option| option.key.to_s == value }

            if selected_option
              process_option_hiding(selected_option)
              process_option_showing(selected_option)
              @depends_on_lookup[selected_option.input_key] = true
            end
          end
        end

        def process_checkbox(question)
          selected_options = question.options.select { |option| !option.inner_title? && answer.send(option.key) == 1 }

          selected_options.each do |option|
            process_option_hiding(option)
            process_option_showing(option)
            @depends_on_lookup[option.input_key] = true
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
  end
end
