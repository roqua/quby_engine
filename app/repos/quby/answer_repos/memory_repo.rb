require 'ostruct'

module Quby
  module AnswerRepos
    class MemoryRepo < AnswerRepo
      class Record < OpenStruct
      end

      private

      def find_record(id)
        storage[id]
      end

      def build_record
        Record.new(_id: SecureRandom.uuid)
      end

      def store_record(record)
        storage[record[:_id]] = record
      end

      def storage
        @storage ||= {}
      end

      def entity(record)
        Quby::Answer.new(record.to_h).tap(&:enhance_by_dsl)
      end
    end
  end
end
