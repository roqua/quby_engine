require 'mongoid'

module Quby
  module AnswerRepos
    class MongoidRepo
      class Record
        include ::Mongoid::Document
        include ::Mongoid::Timestamps
        include OutcomeCalculations

        store_in :answers

        identity type: String
        field :questionnaire_id,     type: Integer
        field :questionnaire_key,    type: String
        field :value,                type: Hash
        field :patient,              type: Hash,    default: {}
        field :token,                type: String
        field :active,               type: Boolean, default: true
        field :test,                 type: Boolean, default: false
        field :completed_at,         type: Time
        field :outcome_generated_at, type: Time
        field :scores,               type: Hash,    default: {}
        field :actions,              type: Hash,    default: {}
        field :completion,           type: Hash,    default: {}
      end

      def find(questionnaire_key, answer_id)
        record = Record.where(questionnaire_key: questionnaire_key).find(answer_id)
        entity(record.attributes)
      end

      def reload(answer)
        find(answer.questionnaire_key, answer.id)
      end

      def create!(questionnaire_key, attributes = {})
        attributes        = attributes.with_indifferent_access
        questionnaire     = Quby.questionnaire_finder.find(questionnaire_key)

        record            = Record.new(questionnaire_key: questionnaire.key)
        record.token      = SecureRandom.hex(8)
        record.patient    = attributes.fetch(:patient,    {})
        record.test       = attributes.fetch(:test,       false)
        record.scores     = attributes.fetch(:scores,     {})
        record.actions    = attributes.fetch(:actions,    {})
        record.completion = attributes.fetch(:completion, {})
        record.value      = (questionnaire.default_answer_value || {}).merge(attributes[:value] || {})
        record.save!

        entity(record.attributes)
      end

      def update!(answer)
        record = Record.find(answer.id)

        # MongoDB won't save new hash order if we don't clear it first.
        record.update_attributes!(scores: {}, actions: {}, completion: {})

        record.value                = answer.value
        record.patient              = answer.patient
        record.token                = answer.token
        record.active               = answer.active
        record.test                 = answer.test
        record.completed_at         = answer.completed_at
        record.outcome_generated_at = answer.outcome_generated_at
        record.scores               = answer.scores
        record.actions              = answer.actions
        record.completion           = answer.completion
        record.save!
      end

      def update(answer)
        update!(answer)
      end

      private

      def entity(attributes)
        Quby::Answer.new(attributes).tap(&:enhance_by_dsl)
      end
    end
  end
end
