module Quby
  module QuestionnaireRepos
    class DiskRepo
      RecordNotFound = Class.new(::Quby::QuestionnairesRepos::RecordNotFound)

      attr_reader :path
      attr_reader :questionnaire_class

      def initialize(path, questionnaire_class = Quby::Questionnaire)
        @path = path
        @questionnaire_class = questionnaire_class
        @questionnaire_cache = {}
      end

      def all
        Dir[File.join(path, "*.rb")].map do |filename|
          key = File.basename(filename, '.rb')
          find(key)
        end
      end

      def find(key)
        raise(RecordNotFound, key) unless exists?(key)

        last_update = last_update_on_disk(key)

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

      def last_update_on_disk(key)
        Time.at(File.ctime(questionnaire_path(key)).to_i)
      end

      def questionnaire_path(key)
        File.join(path, "#{key}.rb")
      end

      def entity(key, definition, last_update)
        questionnaire_class.new(key, definition, last_update)
      end
    end
  end
end
