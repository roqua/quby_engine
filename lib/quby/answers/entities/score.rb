module Quby
  module Answers
    module Entities
      # Score instances enhance answer#scores hash results with score schema information.
      # It also presents the subscores as Subscore objects.

      class Score
        attr_accessor :score_schema
        attr_accessor :subscores

        # The key of the corresponding score in the questionnaire definition
        delegate :key, to: :score_schema
        # A label describing the general purpose of the score
        delegate :label, to: :score_schema
        # An array of SubscoreSchemas describing each key that can be returned in the result hash of a score.
        delegate :subscore_schemas, to: :score_schema
        # access subscores through []
        delegate :[], to: :subscores

        def initialize(score_schema:, score_hash:)
          self.score_schema = score_schema
          @score_hash = score_hash
          initialize_subscores
        end

        def initialize_subscores
          self.subscores = subscore_schemas.map do |subschema|
            [subschema.key, Entities::Subscore.new(subschema: subschema, score_hash: @score_hash)]
          end.to_h.with_indifferent_access
        end

        def referenced_values
          @score_hash[:referenced_values]
        end

        def error
          if @score_hash.has_key?(:exception)
            @score_hash.slice(:backtrace, :exception)
          else
            nil
          end
        end
      end
    end
  end
end
