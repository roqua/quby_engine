module Quby
  class DefinitionValidator
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

      check_if_to_be_hidden_questions_actually_exist(q)

      validate_question_key_length(q)
      validate_question_key_starts_with_v_underscore(q)

      true
    # Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
    rescue Exception => e
      questionnaire.errors.add(:definition, {message: "Questionnaire error: #{questionnaire.key}\n#{e.message}",
                                             backtrace: e.backtrace[0..5].join("<br/>")})
      false
    end

    def check_if_to_be_hidden_questions_actually_exist(q)
      q.questions.compact.each do |question|
        question.options.each do |option|
          if option.hides_questions.present?
            option.hides_questions.each do |key|
              unless q.question_hash[key]
                raise "Question #{question.key} option #{option.key} hides nonexistent question #{key}"
              end
            end
          end
        end
      end
    end

    def validate_question_key_length(q)
      q.questions.compact.each do |question|
        if question.key.to_s.length > 10
          raise "Key van de vraagdefinities mag niet langer dan 10 karakters zijn.<br />" +
                "Vervang `#{question.key}` met een kortere key."
        end
      end
    end

    def validate_question_key_starts_with_v_underscore(q)
      q.questions.compact.each do |question|
        unless question.key.to_s.start_with?('v_')
          raise "Keys van de vraagdefinities moeten beginnen met `v_`. Was `#{question.key}"
        end
      end
    end

  end
end
