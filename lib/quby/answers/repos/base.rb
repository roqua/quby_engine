module Quby
  module Answers
    module Repos
      class Base
        def find(questionnaire_key, answer_id)
          record = find_record(answer_id)
          fail AnswerNotFound, "Answer #{answer_id.inspect} could not be found." unless record.present?
          entity(record)
        end

        def reload(answer)
          find(answer.questionnaire_key, answer.id)
        end

        def all(questionnaire_key)
          records = all_records(questionnaire_key)
          entities(records)
        end

        def create!(questionnaire_key, attributes = {})
          attributes        = attributes.with_indifferent_access
          questionnaire     = Quby.questionnaires.find(questionnaire_key)

          record = build_record
          set_initial_attributes(record, questionnaire, attributes)
          store_record(record)
          entity(record)
        end

        def update!(answer)
          record = find_record(answer.id)
          update_attributes(record, answer)
          store_record(record)
        end

        private

        def set_initial_attributes(record, questionnaire, given_attributes)
          initial_attributes(questionnaire, given_attributes).each do |key, value|
            record.send("#{key}=", value)
          end
        end

        def initial_attributes(questionnaire, given_attributes)
          {
            questionnaire_key:    questionnaire.key,
            token:                SecureRandom.hex(8),
            dsl_last_update:      questionnaire.last_update,
            raw_params:           given_attributes.fetch(:raw_params,           {}),
            import_notes:         given_attributes.fetch(:import_notes,         {}),
            patient:              given_attributes.fetch(:patient,              {}),
            test:                 given_attributes.fetch(:test,                 false),
            outcome_generated_at: given_attributes.fetch(:outcome_generated_at, nil),
            scores:               given_attributes.fetch(:scores,               {}),
            actions:              given_attributes.fetch(:actions,              {}),
            completion:           given_attributes.fetch(:completion,           {}),
            completed_at:         given_attributes.fetch(:completed_at,         nil),
            value:                default_answer_value(questionnaire, given_attributes)
          }
        end

        def default_answer_value(questionnaire, given_attributes)
          quest_value = questionnaire.default_answer_value || {}
          given_value = given_attributes[:value] || {}

          quest_value.merge(given_value).stringify_keys
        end

        def update_attributes(record, answer)
          record.token                = answer.token
          record.dsl_last_update      = answer.dsl_last_update
          record.patient              = answer.patient.stringify_keys
          record.active               = answer.active
          record.test                 = answer.test
          record.raw_params           = answer.raw_params.stringify_keys
          record.import_notes         = answer.import_notes.stringify_keys
          record.value                = answer.value.stringify_keys
          record.completed_at         = answer.completed_at
          record.outcome_generated_at = answer.outcome_generated_at
          record.scores               = answer.scores.stringify_keys
          record.actions              = answer.actions.stringify_keys
          record.completion           = answer.completion.stringify_keys
        end

        def entities(records)
          records.map { |record| entity(record) }
        end

        def entity(record)
          fail NotImplementedError
        end

        def entity_class
          Quby::Answers::Entities::Answer
        end
      end
    end
  end
end
