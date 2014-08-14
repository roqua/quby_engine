require 'active_model'
require 'quby/questionnaires/entities/questionnaire'
require 'quby/answers'

module Quby
  module Questionnaires
    module Services
      class DefinitionValidator < ActiveModel::Validator
        MAX_KEY_LENGTH  = 19
        KEY_PREFIX      = 'v_'

        attr_reader :definition
        attr_reader :questionnaire

        def validate(definition)
          questionnaire = DSL.build_from_definition(definition)
          validate_questions(questionnaire)
          validate_scores(questionnaire)
          validate_table_edgecases(questionnaire)
          validate_outcome_using_example_answers(questionnaire)
        # Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
        rescue Exception => exception
          definition.errors.add(:sourcecode, {message: "Questionnaire error: #{definition.key}\n" \
                                                       "#{exception.message}",
                                              backtrace: exception.backtrace[0..5].join("<br/>")})
        end

        def validate_questions(questionnaire)
          questionnaire.answer_keys.each do |key|
            validate_key_format(key)
          end

          questionnaire.question_hash.each do |key, question|
            subquestions_cant_have_default_invisible question
            validate_subquestion_absence_in_select question

            validate_question_options(questionnaire, question)
          end
        end

        def validate_scores(questionnaire)
          questionnaire.scores.each do |score|
            validate_score_key_length(score)
          end
        end

        def validate_question_options(questionnaire, question)
          question.options.each do |option|
            msg_base = "Question #{option.question.key} option #{option.key}"
            to_be_hidden_questions_exist_and_not_subquestion?(questionnaire, option, msg_base: msg_base)
            to_be_shown_questions_exist_and_not_subquestion?(questionnaire, option, msg_base: msg_base)
          end
        end

        def validate_table_edgecases(questionnaire)
          questionnaire.panels.each do |panel|
            tables = panel.items.select { |item| item.is_a?(Entities::Table) }
            tables.each do |table|
              questions = table.items.select { |item| item.is_a?(Entities::Question) }
              questions.each { |question| validate_table_question(question) }
            end
          end
        end

        def validate_outcome_using_example_answers(questionnaire)
          errors = []
          questionnaire.example_answers.each do |example_answer|
            example_values  = example_answer[:values].stringify_keys
            example_outcome = example_answer[:outcome]
            answer  = Quby::Answers::Entities::Answer.new(questionnaire: questionnaire, value: example_values)
            outcome = Quby::Answers::Services::OutcomeCalculation.new(answer).calculate
            example_outcome.each do |key, score|
              score.each do |field, expected_value|
                gotten_value = outcome.scores[key][field]
                unless gotten_value == expected_value
                  errors << "Outcome test \"#{example_answer[:label]}\" failed. " \
                    "Mismatch in #{key}.#{field}: Got: #{gotten_value}, expected: #{expected_value}"
                end
              end
            end
          end
          fail errors.join("\n") unless errors.empty?
        end

        def to_be_hidden_questions_exist_and_not_subquestion?(questionnaire, option, msg_base:)
          return if option.hides_questions.blank?
          msg_base += " hides_questions"
          option.hides_questions.each do |key|
            validate_question_key_exists?(questionnaire, key, msg_base: msg_base)
            validate_not_subquestion(questionnaire, key, msg_base: msg_base)
          end
        end

        def to_be_shown_questions_exist_and_not_subquestion?(questionnaire, option, msg_base:)
          return if option.shows_questions.blank?
          msg_base += " shows_questions"
          option.shows_questions.each do |key|
            validate_question_key_exists?(questionnaire, key, msg_base: msg_base)
            validate_not_subquestion(questionnaire, key, msg_base: msg_base)
          end
        end

        def subquestions_cant_have_default_invisible(question)
          if question.subquestion? && question.default_invisible
            fail "Question #{question.key} is a subquestion with default_invisible."
          end
        end

        private

        def validate_question_key_exists?(questionnaire, key, msg_base:)
          unless questionnaire.question_hash[key]
            fail msg_base + " references nonexistent question #{key}"
          end
        end

        def validate_not_subquestion(questionnaire, key, msg_base:)
          if questionnaire.question_hash[key].subquestion?
            fail msg_base + " references subquestion #{key}"
          end
        end

        def validate_key_format(key)
          if key.to_s.length > MAX_KEY_LENGTH
            fail "Key '#{key}' should contain at most #{MAX_KEY_LENGTH} characters."
          end
          unless key.to_s.start_with?(KEY_PREFIX)
            fail "Key '#{key}' should start with '#{KEY_PREFIX}'."
          end
        end

        def validate_score_key_length(score)
          if score.key.to_s.length > MAX_KEY_LENGTH
            fail "Score key `#{score.key}` should contain at most #{MAX_KEY_LENGTH} characters."
          end
        end

        def validate_subquestion_absence_in_select(question)
          return unless question.type == :select
          question.options.each do |option|
            unless option.questions.empty?
              fail "Question '#{question.key}' of type ':select' may not include other questions."
            end
          end
        end

        def validate_table_question(question)
          question.subquestions.each do |subquestion|
            if subquestion.presentation != :next_to_title
              fail "Question #{question.key} is inside a table, but has a subquestion #{subquestion.key}, " \
                    "which is not allowed."
            end
          end
        end
      end
    end
  end
end
