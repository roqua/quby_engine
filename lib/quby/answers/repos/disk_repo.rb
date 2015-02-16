require_relative '../repos'
require 'ostruct'
require 'pathname'

module Quby
  module Answers
    module Repos
      class DiskRepo < Base
        class Record < OpenStruct
        end

        attr_reader :path

        def initialize(path)
          @path = Pathname.new(path).expand_path
        end

        def find_completed_after(time, answer_ids)
          records = storage.map { |filename| load_file(filename) }.select do |record|
            answer_ids.include?(record._id) && record.completed_at.present? && record.completed_at > time
          end
          records.map { |record| entity(record) }
        end

        private

        def all_records(questionnaire_key)
          storage.map    { |filename| load_file(filename) }
                                 .select { |record| record.questionnaire_key == questionnaire_key }
        end

        def find_record(id)
          load_file(path.join("answer-#{id}.yml"))
        rescue StandardError => e
          puts e.message
          nil
        end

        def load_file(filename)
          File.open(filename, 'r') do |file|
            YAML.load(file.read)
          end
        end

        def build_record
          Record.new(_id: SecureRandom.uuid)
        end

        def store_record(record)
          File.open(path.join("answer-#{record[:_id]}.yml"), 'w') do |file|
            file.write YAML.dump(record)
          end
        end

        def storage
          Dir[path.join("*.yml")]
        end

        def entity(record)
          entity_class.new(record.to_h).tap(&:enhance_by_dsl)
        end
      end
    end
  end
end
