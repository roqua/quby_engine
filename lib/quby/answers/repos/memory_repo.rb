# frozen_string_literal: true

require 'ostruct'

module Quby
  module Answers
    module Repos
      class MemoryRepo < Base
        class Record < OpenStruct
        end

        def find_completed_after(time, answer_ids)
          records = storage.values.select do |record|
            answer_ids.include?(record._id) && record.completed_at.present? && record.completed_at > time
          end
          records.map { |record| entity(record) }
        end

        private

        def all_records(questionnaire_key)
          storage.values.select { |record| record.questionnaire_key == questionnaire_key }
        end

        def find_record(id)
          storage[id]
        end

        def build_record
          Record.new(_id: SecureRandom.uuid)
        end

        def store_record(record)
          storage[record[:_id]] = record
          record.created_at = Time.zone.now
        end

        def storage
          @storage ||= {}
        end

        def entity(record)
          entity_class.new(record.to_h).tap(&:enhance_by_dsl)
        end
      end
    end
  end
end
