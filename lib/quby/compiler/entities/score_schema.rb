module Quby
  module Compiler
    module Entities
      # ScoreSchema instances describe score definitions.
      #
      # Score definitions are blocks of ruby code that return a hash of score results based on a questionnaire
      # response (answer). These schemas describe the purpose and form of the scores. Each key-value pair of the result
      # hash is called a subscore.
      # The :value subscore is treated as the main score result. Subscores are usually identified by their 'export_key'.
      # The score value's export_key is usually set to a shortened version of the main score key.
      class ScoreSchema
        include ActiveModel::Model

        # The key of the corresponding score in the questionnaire definition
        attr_accessor :key
        # A label describing the general purpose of the score
        attr_accessor :label
        # An array of SubscoreSchemas describing each key that can be returned in the result hash of a score.
        attr_accessor :subscore_schemas

        validates :key, :label, :subscore_schemas, presence: true
        validates :subscore_schemas, 'quby/array_attribute_valid': true

        def initialize(attributes)
          super(attributes)
          initialize_subscore_schemas
        end

        def initialize_subscore_schemas
          self.subscore_schemas = subscore_schemas&.map { |suboptions| Entities::SubscoreSchema.new suboptions }
        end

        def export_key_labels
          subscore_schemas.map { |schema| [schema.export_key, schema.label] }.to_h.with_indifferent_access
        end
      end
    end
  end
end
