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
      true
    # Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
    rescue Exception => e
      questionnaire.errors.add(:definition, {message: "Questionnaire error: #{questionnaire.key}\n#{e.message}", backtrace: e.backtrace[0..5].join("<br/>")})
      false
    end

    def check_if_to_be_hidden_questions_actually_exist(q)
      q.questions.compact.each do |question|
        question.options.each do |option|
          if option.hides_questions.present?
            option.hides_questions.each do |key|
              raise "Question #{question.key} option #{option.key} hides nonexistent question #{key}" unless q.question_hash[key]
            end
          end
        end
      end
    end

  end
end