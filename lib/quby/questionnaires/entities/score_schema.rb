module Quby
  module Questionnaires
    module Entities
      class ScoreSchema
        include ActiveModel::Model

        attr_accessor :key, :label, :sub_score_schemas
        validates :key, :label, :sub_score_schemas, presence: true
        validate :sub_score_schemas_valid

        def initialize(attributes)
          super(attributes)
          initialize_sub_score_schemas
        end

        def initialize_sub_score_schemas
          self.sub_score_schemas = sub_score_schemas&.map { |suboptions| Entities::SubScoreSchema.new suboptions }
        end

        def sub_score_schemas_valid
          if sub_score_schemas.present?
            if !sub_score_schemas.all? { |schema| schema.is_a?(Entities::SubScoreSchema) }
              errors.add(:sub_score_schemas, :invalid)
            elsif sub_score_schemas.reject(&:valid?).any?
              sub_errors = sub_score_schemas.map do |sub_schema|
                sub_schema.errors.full_messages
              end.join(', ')
              errors.add(:sub_score_schemas, sub_errors)
            end
          end
        end

        def export_key_labels
          sub_score_schemas.map { |schema| [schema.export_key, schema.label] }.to_h.with_indifferent_access
        end
      end
    end
  end
end
