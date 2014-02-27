module Quby
  class DefinitionValidator
    MAX_KEY_LENGTH  = 13
    KEY_PREFIX      = 'v_'

    attr_reader :questionnaire
    attr_reader :definition

    def initialize(questionnaire, definition)
      @questionnaire = questionnaire
      @definition    = definition
    end

    def validate
      dummy_questionnaire = Quby::Questionnaire.new(@questionnaire.key)

      functions = Function.all.map(&:definition).join("\n\n")
      QuestionnaireDsl.enhance(dummy_questionnaire, [functions, definition].join("\n\n"))

      validate_questions(dummy_questionnaire)
      validate_table_edgecases(dummy_questionnaire)

      true
    # Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
    rescue Exception => exception
      questionnaire.errors.add(:definition, {message: "Questionnaire error: #{questionnaire.key}\n#{exception.message}",
                                             backtrace: exception.backtrace[0..5].join("<br/>")})
      false
    end

    def validate_questions(questionnaire)
      questionnaire.question_hash.each do |key, question|
        validate_key_format key
        if question.is_a? Quby::Items::Question
          to_be_hidden_questions_exist? question, questionnaire
          if question.type == :date
            validate_key_format question.year_key
            validate_key_format question.month_key
            validate_key_format question.day_key
          end
        end
        if question.type == :select
          validate_subquestion_absence_in_select question
        end
        if question.type == :check_box
          question.options.andand.select { |option| not option.inner_title }
                                 .each { |option| validate_key_format option.key }
        end
      end
    end

    def validate_table_edgecases(questionnaire)
      questionnaire.panels.each do |panel|
        tables = panel.items.select {|item| item.is_a?(Quby::Items::Table) }
        tables.each do |table|
          questions = table.items.select {|item| item.is_a?(Quby::Items::Question) }
          questions.each {|question| validate_table_question(question) }
        end
      end
    end

    def to_be_hidden_questions_exist?(question, questionnaire)
      question.options.each do |option|
        next if option.hides_questions.blank?
        option.hides_questions.each do |key|
          unless questionnaire.question_hash[key]
            raise "Question #{question.key} option #{option.key} hides nonexistent question #{key}"
          end
        end
      end
    end

    private

    def validate_key_format(key)
      if key.to_s.length > MAX_KEY_LENGTH
        raise "Key '#{key}' should contain at most #{MAX_KEY_LENGTH} characters."
      end
      if not key.to_s.start_with?(KEY_PREFIX)
        raise "Key '#{key}' should start with '#{KEY_PREFIX}'."
      end
    end

    def compact_questions(q)
      q.questions.compact
    end

    def validate_subquestion_absence_in_select(question)
      question.options.each do |option|
        unless option.questions.empty?
          raise "Question '#{question.key}' of type ':select' may not include other questions."
        end
      end
    end

    def validate_table_question(question)
      question.subquestions.each do |subquestion|
        if subquestion.presentation != :next_to_title
          raise "Question #{question.key} is inside a table, but has a subquestion #{subquestion.key}, which is not allowed."
        end
      end
    end
  end
end
