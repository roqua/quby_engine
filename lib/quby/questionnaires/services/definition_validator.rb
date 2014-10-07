require 'active_model'
require 'quby/questionnaires/entities/questionnaire'

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
          validate_flags(questionnaire)
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

        def validate_flags(questionnaire)
          questionnaire.flags.each do |flag_key, flag|
            shows_questions = flag.shows_questions
            hides_questions = flag.hides_questions
            unknown_shows_questions = shows_questions.select { |key| !questionnaire.key_in_use?(key) }
            unknown_hides_questions = hides_questions.select { |key| !questionnaire.key_in_use?(key) }

            if unknown_shows_questions.present?
              fail(ArgumentError, "Flag '#{key}' has unknown shows_questions keys #{unknown_shows_questions}")
            end
            if unknown_hides_questions.present?
              fail(ArgumentError, "Flag '#{key}' has unknown hides_questions keys #{unknown_hides_questions}")
            end
          end
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
