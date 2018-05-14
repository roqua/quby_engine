# ScoreSchema instances describe score definitions.
module Quby
  module Questionnaires
    module Entities
      class ScoreSchema
        include ActiveModel::Model
        include ValidatesAttribute

        # The key of the corresponding score
        attr_accessor :key
        # A label describing the general purpose of the score
        attr_accessor :label
        # An array of SubScoreSchemas describing each key that can be returned in the result hash of a score
        attr_accessor :sub_score_schemas

        validates :key, :label, :sub_score_schemas, presence: true
        validates_array_attribute :sub_score_schemas

        def initialize(attributes)
          super(attributes)
          initialize_sub_score_schemas
        end

        def initialize_sub_score_schemas
          self.sub_score_schemas = sub_score_schemas&.map { |suboptions| Entities::SubScoreSchema.new suboptions }
        end

        def export_key_labels
          sub_score_schemas.map { |schema| [schema.export_key, schema.label] }.to_h.with_indifferent_access
        end
      end
    end
  end
end
