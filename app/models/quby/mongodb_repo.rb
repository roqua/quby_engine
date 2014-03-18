module Quby
  class MongodbRepo
    def find(questionnaire_key, answer_id)
      Quby::Answer.where(questionnaire_key: questionnaire_key).find(answer_id)
    end

    def create!(questionnaire_key, attributes = {})
      Quby::Answer.create!(attributes.merge(questionnaire_key: questionnaire_key))
    end

    def create(questionnaire_key, attributes = {})
      Quby::Answer.create(attributes.merge(questionnaire_key: questionnaire_key))
    end

    def update!(answer)
      answer.save!
    end

    def update(answer)
      answer.save
    end
  end
end