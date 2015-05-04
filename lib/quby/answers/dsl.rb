module Quby
  module Answers
    module DSL
      def self.enhance(target_instance)
        answer = target_instance
        questionnaire = target_instance.questionnaire
        answer.dsl_last_update = questionnaire.last_update
        answer.extend(questionnaire.answer_dsl_module)
      end
    end
  end
end
