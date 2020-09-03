module Quby
  module Answers
    module Entities
      # Score instances enhance answer#scores hash results with score schema information.
      # It also splits up the different subscores into SubScore objects.

      class Score
        include ActiveModel::Model

        attr_accessor :score_schema
        attr_accessor :score_hash
        attr_accessor :sub_scores

        # The key of the corresponding score in the questionnaire definition
        delegate :key, to: :score_schema
        # A label describing the general purpose of the score
        delegate :label, to: :score_schema
        # An array of SubScoreSchemas describing each key that can be returned in the result hash of a score.
        delegate :sub_score_schemas, to: :score_schema

        validates :score_hash, :score_schema, presence: true

        def initialize(attributes)
          super(attributes)
          initialize_sub_scores
        end

        def initialize_sub_scores
          self.sub_scores = sub_score_schemas.map do |sub_schema|
            Entities::SubScore.new sub_schema: sub_schema,
                                   score_hash: score_hash
          end
        end

        def value
          score_hash[:value]
        end

        def referenced_values
          score_hash[:referenced_values]
        end
      end
    end
  end
end
