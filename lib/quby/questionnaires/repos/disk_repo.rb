require 'quby/questionnaires/repos'
require 'quby/questionnaires'

module Quby
  module Questionnaires
    module Repos
      class DiskRepo < Base
        attr_reader :path

        def initialize(path)
          @path = path
          @questionnaire_cache = {}
        end

        def keys
          Dir[File.join(path, "*.rb")].map do |filename|
            File.basename(filename, '.rb')
          end
        end

        def find(key)
          fail(QuestionnaireNotFound, key) unless exists?(key)
          definition = File.read(questionnaire_path(key))
          timestamp  = timestamp(key)
          entity(key, definition, timestamp)
        end

        def exists?(key)
          questionnaire_path = questionnaire_path(key)
          File.exist?(questionnaire_path)
        end

        def timestamp(key)
          Time.at(File.mtime(questionnaire_path(key)).to_i)
        end

        private

        def store!(key, definition)
          File.open(questionnaire_path(key), 'w') { |f| f.write definition }
          FileUtils.touch questionnaire_path(key), mtime: Time.now
        end

        def questionnaire_path(key)
          File.join(path, "#{key}.rb")
        end
      end
    end
  end
end
