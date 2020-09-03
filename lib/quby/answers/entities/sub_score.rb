module Quby
  module Answers
    module Entities
      # SubScore instances describe the subscore keys of answer#scores using score schema information.

      class SubScore
        include ActiveModel::Model

        attr_accessor :sub_schema
        attr_accessor :score_hash

        # The key this subscore has in the hash returned by the score
        delegate :key, to: :sub_schema
        # The description of this subscore in the context of the score, like 'Mean', 'T-Score' or 'Interpretation'
        delegate :label, to: :sub_schema
        # The shortened key that will used as the field/column name for csv and oru exports,
        # excluding the questionnaire key part
        delegate :export_key, to: :sub_schema
        # Whether this score will only be exported through oru/api/data exports, but not shown in interfaces
        delegate :only_for_export, to: :sub_schema

        validates :sub_schema, :score_hash, presence: true

        def value
          score_hash[key]
        end
      end
    end
  end
end
