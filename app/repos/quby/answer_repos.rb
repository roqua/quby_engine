module Quby
  module AnswerRepos
    class AnswerRepo
      def find(questionnaire_key, answer_id)
        record = find_record(answer_id)
        entity(record)
      end

      def reload(answer)
        find(answer.questionnaire_key, answer.id)
      end

      def create!(questionnaire_key, attributes = {})
        attributes        = attributes.with_indifferent_access
        questionnaire     = Quby.questionnaire_finder.find(questionnaire_key)

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

      def update(answer)
        update!(answer)
      end

      private

      def set_initial_attributes(record, questionnaire, given_attributes)
        default_attributes(questionnaire, given_attributes).each do |key, value|
          record.send("#{key}=", value)
        end
      end

      def initial_attributes(questionnaire, given_attributes)
        {
          questionnaire_key: questionnaire.key,
          token:             SecureRandom.hex(8),
          dsl_last_update:   questionnaire.last_update,
          patient:           given_attributes.fetch(:patient,      {}),
          test:              given_attributes.fetch(:test,         false),
          scores:            given_attributes.fetch(:scores,       {}),
          actions:           given_attributes.fetch(:actions,      {}),
          completion:        given_attributes.fetch(:completion,   {}),
          completed_at:      given_attributes.fetch(:completed_at, nil),
          value:             default_answer_value(questionnaire, given_attributes)
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
        record.patient              = answer.patient
        record.active               = answer.active
        record.test                 = answer.test
        record.value                = answer.value.stringify_keys
        record.completed_at         = answer.completed_at
        record.outcome_generated_at = answer.outcome_generated_at
        record.scores               = answer.scores
        record.actions              = answer.actions
        record.completion           = answer.completion
      end
    end
  end
end
