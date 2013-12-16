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
      q = Quby::Questionnaire.new(questionnaire.key)

      functions = Function.all.map(&:definition).join("\n\n")
      QuestionnaireDsl.enhance(q, [functions, definition].join("\n\n"))

      validate_questions(q)

      true
    # Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
    rescue Exception => e
      questionnaire.errors.add(:definition, {message: "Questionnaire error: #{questionnaire.key}\n#{e.message}",
                                             backtrace: e.backtrace[0..5].join("<br/>")})
      false
    end

    def validate_questions(q)
      compact_questions(q).each do |question|
        check_if_to_be_hidden_questions_actually_exist question

        validate_key_format question.year_key
        validate_key_format question.month_key
        validate_key_format question.day_key
      end

      q.question_hash.keys.each do |key|
        validate_key_format key
      end
    end

    def check_if_to_be_hidden_questions_actually_exist(question)
      question.options.each do |option|
        next if option.hides_questions.blank?
        option.hides_questions.each do |key|
          unless q.question_hash[key]
            raise "Question #{question.key} option #{option.key} hides nonexistent question #{key}"
          end
        end
      end
    end

    private

    def validate_key_format(key)
      if key.to_s.length > MAX_KEY_LENGTH
        raise "Key `#{key}` mag niet langer zijn dan #{MAX_KEY_LENGTH} karakters."
      end
      if not key.to_s.start_with?(KEY_PREFIX)
        raise "Key `#{key}` moet beginnen met een `#{KEY_PREFIX}`."
      end
    end

    def compact_questions(q)
      q.questions.compact
    end

  end
end
