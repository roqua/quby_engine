require 'method_source'

module Quby
  module Compiler
    module Outputs
      class QubyFrontendV1Serializer
        attr_reader :questionnaire

        def initialize(questionnaire)
          @questionnaire = questionnaire
        end

        def fields
          questionnaire.fields.question_hash.transform_values do |question|
            {
              key: question.key
            }
          end
        end

        def score_calculations
          questionnaire.score_calculations.transform_values do |score_calculation|
            {
              key: score_calculation.key,
              label: score_calculation.label,
              sbg_key: score_calculation.sbg_key,
              options: score_calculation.options,
              sourcecode: score_calculation.calculation.to_proc.source
            }

          end
        end

        def score_schemas
          questionnaire.score_schemas.transform_values do |schema|
            {
              key: schema.key,
              label: schema.label,
              subscore_schemas: schema.subscore_schemas.map do |subschema|
                {
                  key: subschema.key,
                  label: subschema.label,
                  export_key: subschema.export_key,
                  only_for_export: subschema.only_for_export
                }
              end
            }
          end
        end

        def as_json
          {
            key: questionnaire.key,
            title: questionnaire.title,
            description: questionnaire.description,
            outcome_description: questionnaire.outcome_description,
            short_description: questionnaire.short_description,
            fields: questionnaire.fields.as_json,
            panels: questionnaire.panels.as_json,
            flags: questionnaire.flags,
            textvars: questionnaire.textvars,
            validations: questionnaire.validations,
            score_calculations: score_calculations,
            score_schemas: score_schemas,
          }
        end
      end
    end
  end
end