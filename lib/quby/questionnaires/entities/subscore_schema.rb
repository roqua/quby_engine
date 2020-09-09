module Quby
  module Questionnaires
    module Entities
      # SubscoreSchema instances describe each key that could be returned in a score result hash

      class SubscoreSchema
        include ActiveModel::Model

        # The key this subscore has in the hash returned by the score
        attr_accessor :key
        # The description of this subscore in the context of the score, like 'Mean', 'T-Score' or 'Interpretation'
        attr_accessor :label
        # The shortened key that will used as the field/column name for csv and oru exports,
        # excluding the questionnaire key part
        attr_accessor :export_key
        # Whether this score will only be exported through oru/api/data exports, but not shown in interfaces
        attr_accessor :only_for_export

        validates :key, :label, :export_key, presence: true
        validate :key_is_symbol
        validate :export_key_is_symbol

        def key_is_symbol
          errors.add(:key, 'is not a symbol') unless key.is_a?(Symbol)
        end

        def export_key_is_symbol
          errors.add(:export_key, 'is not a symbol') unless export_key.is_a?(Symbol)
        end
      end
    end
  end
end
