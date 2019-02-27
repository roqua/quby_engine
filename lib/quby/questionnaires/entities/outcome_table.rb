module Quby
  module Questionnaires
    module Entities
      # OutcomeTable describes how scores are formatted in a table in outcome views
      # @param key [Symbol] key to reference this outcome table by
      # @param score_keys [Array<Symbol>] which scores are selected for the rows of the table
      # @param subscore_keys [Array<Symbol>] which subscores (:value, :interpretation etc.) make up the table columns
      # @param name [String] a title that will be shown above the table
      # @param default_collapsed [Boolean] if true, collapses the table to only show the name by default
      # @param questionnaire [Questionnaire] for validating score keys and subscore keys according to its score_schema
      class OutcomeTable
        include ActiveModel::Model
        attr_accessor :score_keys, :subscore_keys, :name, :default_collapsed, :questionnaire, :key

        validates :score_keys, :subscore_keys, :questionnaire, :key, presence: true
        validates :name, presence: true, if: proc { |table| table.default_collapsed }
        validate :references_existing_score_keys

        def references_existing_score_keys
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
