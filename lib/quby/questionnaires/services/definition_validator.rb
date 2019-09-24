# frozen_string_literal: true

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
          validate_fields(questionnaire)
          validate_title(questionnaire)
          validate_questions(questionnaire)
          validate_scores(questionnaire)
          validate_table_edgecases(questionnaire)
          validate_flags(questionnaire)
          validate_respondent_types(questionnaire)
          validate_outcome_tables(questionnaire)
        # Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
        rescue Exception => exception # rubocop:disable Lint/RescueException
          definition.errors.add(:sourcecode, {message: "Questionnaire error: #{definition.key}\n" \
                                                       "#{exception.message}",
                                              backtrace: exception.backtrace[0..5].join("<br/>")})
        end

        def validate_fields(questionnaire)
          questionnaire.fields.input_keys
                              .find { |k| !k.is_a?(Symbol) }
                             &.tap { |k| fail "Input key #{k} is not a symbol" }
          questionnaire.fields.answer_keys
                              .find { |k| !k.is_a?(Symbol) }
                             &.tap { |k| fail "Answer key #{k} is not a symbol" }
        end

        def validate_title(questionnaire)
          if questionnaire.title.blank?
            fail "Questionnaire title is missing."
          end
        end

        def validate_questions(questionnaire)
          questionnaire.answer_keys.each do |key|
            validate_key_format(key)
          end

          questionnaire.question_hash.each_value do |question|
            validate_question(question)
            subquestions_cant_have_default_invisible question
            validate_subquestion_absence_in_select question
            validate_placeholder_options_nil_values question
            validate_values_unique question

            validate_question_options(questionnaire, question)
            validate_presence_of_titles question
            validate_no_spaces_before_question_nr_in_title question
          end
        end

        def validate_question(question)
          unless question.valid?
            fail "Question #{question.key} is invalid: #{question.errors.full_messages.join(', ')}"
          end
        end

        def validate_scores(questionnaire)
          questionnaire.scores.each do |score|
            validate_score_key_length(score)
            validate_score_label_present(score)
          end
        end

        def validate_question_options(questionnaire, question)
          question.options.each do |option|
            msg_base = "Question #{option.question.key} option #{option.key}"
            to_be_hidden_questions_exist_and_not_subquestion?(questionnaire, option, msg_base: msg_base)
            to_be_shown_questions_exist_and_not_subquestion?(questionnaire, option, msg_base: msg_base)
          end
        end

        def validate_presence_of_titles(question)
          return if question.allow_blank_titles
          if !question.subquestion? && question.title.blank? && question.context_free_title.blank?
            fail "Question #{question.key} must define either `:title` or `:context_free_title`."
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
          questionnaire.flags.each_value do |flag|
            validate_flag_shows(questionnaire, flag)
            validate_flag_hides(questionnaire, flag)
            validate_flag_depends_on(questionnaire, flag)
          end
        end

        def validate_flag_shows(questionnaire, flag)
          unknown_questions = flag.shows_questions.select { |key| !questionnaire.key_in_use?(key) }
          return if unknown_questions.blank?

          fail ArgumentError, "Flag '#{key}' has unknown shows_questions keys #{unknown_questions}"
        end

        def validate_flag_hides(questionnaire, flag)
          unknown_questions = flag.hides_questions.select { |key| !questionnaire.key_in_use?(key) }
          return if unknown_questions.blank?

          fail ArgumentError, "Flag '#{key}' has unknown hides_questions keys #{unknown_questions}"
        end

        def validate_flag_depends_on(questionnaire, flag)
          return if flag.depends_on.blank? || questionnaire.flags.key?(flag.depends_on)

          fail ArgumentError, "Flag #{flag.key} depends_on nonexistent flag '#{flag.depends_on}'"
        end

        def validate_respondent_types(questionnaire)
          valid_respondent_types = Entities::Questionnaire::RESPONDENT_TYPES

          invalid_types = questionnaire.respondent_types - valid_respondent_types

          if invalid_types.present?
            fail "Invalid respondent types: :#{invalid_types.join(', :')}\n"\
                 "Choose one or more from: :#{valid_respondent_types.join(', :')}"
          end
        end

        def validate_outcome_tables(questionnaire)
          questionnaire.outcome_tables.each do |table|
            next if table.valid?
            fail "Outcome table #{table.errors.full_messages}"
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

        # Don't write question numbers as "  1. Title", but as "1\\. Title".
        def validate_no_spaces_before_question_nr_in_title(question)
          if question.title && question.title.match(/^\s{2,}\d+\\\./)
            fail "Question with number does not need leading spaces."
          end
        end

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

        def validate_score_label_present(score)
          fail "Score #{score.key} label must be passed in as an option." unless score.label.present?
        end

        def validate_subquestion_absence_in_select(question)
          return unless question.type == :select
          question.options.each do |option|
            unless option.questions.empty?
              fail "Question '#{question.key}' of type ':select' may not include other questions."
            end
          end
        end

        def validate_placeholder_options_nil_values(question)
          question.options.each do |question_option|
            if question_option.placeholder && question_option.value.present?
              fail "#{question.key}:#{question_option.key}: Placeholder options should not have values defined."
            end
          end
        end

        def validate_values_unique(question)
          return if question.type == :check_box || question.allow_duplicate_option_values

          question.options.each_with_object([]) do |question_option, seen_values|
            next if question_option.placeholder || question_option.inner_title

            fail "#{question.key}:#{question_option.key}: Has no option value defined." if question_option.value.blank?
            if seen_values.include?(question_option.value)
              fail "#{question.key}:#{question_option.key}: " \
                      "Another option with value #{question_option.value} is already defined."
            end
            seen_values << question_option.value
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
