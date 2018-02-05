module Quby
  module Questionnaires
    module Entities
      class SubScoreSchema
        include ActiveModel::Model

        attr_accessor :key, :label, :export_key
        validates :key, :label, :export_key, presence: true
      end
    end
  end
end
