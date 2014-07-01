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

        def all
          Dir[File.join(path, "*.rb")].map do |filename|
            key = File.basename(filename, '.rb')
            find(key)
          end
        end

        def find(key)
          fail(QuestionnaireNotFound, key) unless exists?(key)

          last_update = timestamp(key)

          if @questionnaire_cache[key] && last_update.to_i == @questionnaire_cache[key].last_update.to_i
            @questionnaire_cache[key]
          else
            definition                = File.read(questionnaire_path(key))
            questionnaire             = entity(key, definition, last_update)
            @questionnaire_cache[key] = questionnaire
          end
        end

        def exists?(key)
          questionnaire_path = questionnaire_path(key)
          File.exist?(questionnaire_path)
        end

        def timestamp(key)
          Time.at(File.ctime(questionnaire_path(key)).to_i)
        end

        def create!(key, definition)
          fail(DuplicateQuestionnaire, key) if exists?(key)
          File.open(questionnaire_path(key), 'w') { |f| f.write definition }
          find(key)
        end

        private

        def questionnaire_path(key)
          File.join(path, "#{key}.rb")
        end
      end
    end
  end
end
