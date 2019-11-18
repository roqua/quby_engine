# frozen_string_literal: true

module Quby
  module Answers
    module Repos
      class Base
        def find(questionnaire_key, answer_id, options = {})
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

        def create!(answer)
          record = build_record
          record.questionnaire_key = answer.questionnaire_key
          update_attributes(record, answer)
          store_record(record)
          entity(record)
        end

        def update!(answer)
          record = find_record(answer.id)
          update_attributes(record, answer)
          store_record(record)
        end

        private

        def update_attributes(record, answer)
          record.token                = answer.token
          record.dsl_last_update      = answer.dsl_last_update
          record.patient              = answer.patient.stringify_keys
          record.active               = answer.active
          record.test                 = answer.test
          record.import_notes         = answer.import_notes.stringify_keys
          record.value                = answer.value.stringify_keys
          record.started_at           = answer.started_at
          record.observation_time     = answer.observation_time
          record.entered_at           = answer.entered_at
          record.outcome_generated_at = answer.outcome_generated_at
          record.scores               = answer.scores.stringify_keys
          record.actions              = answer.actions.stringify_keys
          record.completion           = answer.completion.stringify_keys
          record.flags                = answer.flags
          record.textvars             = answer.textvars
          record.raw_params           = convert_raw_params_to_hash(answer.raw_params).stringify_keys
        end

        def convert_raw_params_to_hash(raw_params)
          if raw_params.respond_to?(:to_unsafe_h)
            raw_params.to_unsafe_h
          else
            raw_params
          end
        end

        def entities(records)
          records.map { |record| entity(record) }
        end

        def entity(record)
          fail NotImplementedError
        end

        def entity_class
          Entities::Answer
        end
      end
    end
  end
end
