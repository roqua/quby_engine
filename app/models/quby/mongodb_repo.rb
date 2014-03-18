module Quby
  class MongodbRepo
    attr_reader :mongo_collection

    def initialize(mongo_collection)
      @mongo_collection = mongo_collection
    end

    def find(questionnaire_key, answer_id)
      attributes = mongo_collection.find_one(questionnaire_key: questionnaire_key, _id: answer_id)

      entity = Quby::Answer.new(attributes)
      entity.instance_variable_set(:@new_record, nil)
      entity.instance_variable_set(:@changed_attributes, nil)
      entity.instance_variable_set(:@pending_nested, nil)
      entity.instance_variable_set(:@pending_relations, nil)
      entity
    end

    def create!(questionnaire_key, attributes = {})
      Quby::Answer.create!(attributes.merge(questionnaire_key: questionnaire_key))
    end

    def create(questionnaire_key, attributes = {})
      Quby::Answer.create(attributes.merge(questionnaire_key: questionnaire_key))
    end

    def update!(answer)
      mongo_collection.update({"_id" => answer.id}, answer.attributes)
    end

    def update(answer)
      mongo_collection.update({"_id" => answer.id}, answer.attributes)
    end
  end
end