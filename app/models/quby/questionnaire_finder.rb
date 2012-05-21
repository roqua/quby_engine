module Quby
  class QuestionnaireFinder
    class RecordNotFound < StandardError; end

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

      questionnaire_path = questionnaire_path(key)
      last_update = Time.at(File.ctime(questionnaire_path).to_i)

      if @questionnaire_cache[key] and last_update.to_i == @questionnaire_cache[key].last_update.to_i
        return @questionnaire_cache[key]
      else
        definition = File.read(questionnaire_path)

        questionnaire = questionnaire_class.new(key, definition, last_update)
        questionnaire.persisted = true

        @questionnaire_cache[key] = questionnaire
      end
    end

    def exists?(key)
      questionnaire_path = questionnaire_path(key)

      File.exist?(questionnaire_path)
    end


    def questionnaire_path(key)
      File.join(path, "#{key}.rb")
    end
  end
end
