# SubScoreSchema instances describe each key that could be returned in the score result hash
module Quby
  module Questionnaires
    module Entities
      class SubScoreSchema
        include ActiveModel::Model

        # the key this subscore has in the hash returned by the score
        attr_accessor :key
        # the description of this subscore in the context of the score, like 'T-Score' or 'Interpretation'
        attr_accessor :label
        # the shortened key that will used as the field/column name for csv and oru exports,
        # excludes the questionnaire key part
        attr_accessor :export_key
        # whether this score will only be exported through oru/api/data exports,  but not shown in interfaces
        attr_accessor :only_for_export

        validates :key, :label, :export_key, presence: true
      end
    end
  end
end
