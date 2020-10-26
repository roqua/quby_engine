# frozen_string_literal: true

require 'quby/questionnaires/repos'
require 'quby/questionnaires'

module Quby
  module Questionnaires
    module Repos
      class BundleDiskRepo < Base
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
          json = read(key)
          timestamp = Time.zone.parse(read(key)["last_update"])
          Entities::Definition.new(key: key, path: questionnaire_path(key), json: json, timestamp: timestamp)
        end

        def exists?(key)
          questionnaire_path = questionnaire_path(key)
          File.exist?(questionnaire_path)
        end

        def timestamp(key)
          Time.zone.parse(read(key)["last_update"])
        end

        private

        def read(key)
          JSON.parse(File.read(questionnaire_path(key)))
        end

        def questionnaire_path(key)
          File.join(path,key, "quby-frontend-v1.json")
        end
      end
    end
  end
end
