module Quby
  class MongodbRepo
    def find(questionnaire_key, answer_id)
      Quby::Answer.where(questionnaire_key: questionnaire_key).find(answer_id)
    end

    def create(questionnaire_key)
      Quby::Answer.create(questionnaire_key: questionnaire_key)
    end
  end
end