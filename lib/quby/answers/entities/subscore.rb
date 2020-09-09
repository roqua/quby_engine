module Quby
  module Answers
    module Entities
      # Subscore instances describe the subscore keys of answer#scores using score schema information.

      class Subscore
        attr_accessor :subschema

        # The key this subscore has in the hash returned by the score
        delegate :key, to: :subschema
        # The description of this subscore in the context of the score, like 'Mean', 'T-Score' or 'Interpretation'
        delegate :label, to: :subschema
        # The shortened key that will used as the field/column name for csv and oru exports,
        # excluding the questionnaire key part
        delegate :export_key, to: :subschema
        # Whether this score will only be exported through oru/api/data exports, but not shown in interfaces
        delegate :only_for_export, to: :subschema

        def initialize(subschema:, score_hash:)
          self.subschema = subschema
          @score_hash = score_hash
        end

        def value
          @score_hash[key]
        end
      end
    end
  end
end
