require 'mongoid'

module Quby
  module AnswerRepos
    class MongoidRepo < AnswerRepo
      class Record
        include ::Mongoid::Document
        include ::Mongoid::Timestamps
        include OutcomeCalculations

        store_in :answers

        identity type: String
        field :questionnaire_id,     type: Integer
        field :questionnaire_key,    type: String
        field :raw_params,           type: Hash
        field :value,                type: Hash
        field :import_notes,         type: Hash
        field :patient,              type: Hash,    default: {}
        field :token,                type: String
        field :active,               type: Boolean, default: true
        field :test,                 type: Boolean, default: false
        field :completed_at,         type: Time
        field :outcome_generated_at, type: Time
        field :scores,               type: Hash,    default: {}
        field :actions,              type: Hash,    default: {}
        field :completion,           type: Hash,    default: {}
        field :dsl_last_update,      type: Time
      end

      def find_completed_after(time, answer_ids)
        records = Record.any_in(_id: answer_ids).where(:completed_at.gt => time)
        records.map { |record| entity(record) }
      end

      def update!(answer)
        record = find_record(answer.id)
        # MongoDB won't save new hash order if we don't clear it first.
        record.update_attributes!(scores: {}, actions: {}, completion: {})
        update_attributes(record, answer)
        store_record(record)
      end

      private

      def find_record(id)
        Record.find(id)
      rescue Mongoid::Errors::DocumentNotFound, Mongoid::Errors::InvalidFind
        raise AnswerNotFound, "Answer #{id.inspect} could not be found."
      end

      def build_record
        Record.new
      end

      def store_record(record)
        record.save!
      end

      def entity(record)
        Quby::Answer.new(record.attributes).tap(&:enhance_by_dsl)
      end
    end
  end
end
