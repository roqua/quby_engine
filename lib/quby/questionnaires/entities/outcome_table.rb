module Quby
  module Questionnaires
    module Entities
      class OutcomeTable
        include ActiveModel::Model
        attr_accessor :score_keys, :subscore_keys, :name, :default_collapsed, :questionnaire

        validates :score_keys, :subscore_keys, presence: true
        validates :name, presence: true, if: Proc.new { |table| table.default_collapsed }
        validate :references_existing_score_keys

        def references_existing_score_keys
          return if questionnaire.score_schemas.blank?
          (score_keys - questionnaire.score_schemas.values.map(&:key)).each do |missing_key|
            errors.add :score_keys, "#{missing_key.inspect} not found in score schemas"
          end
          existing_subscore_keys = questionnaire.score_schemas.values.flat_map(&:sub_score_schemas).map(&:key)
          (subscore_keys - existing_subscore_keys).each do |missing_key|
            errors.add :subscore_keys, "#{missing_key.inspect} not found in subscore schemas"
          end
        end
      end
    end
  end
end
