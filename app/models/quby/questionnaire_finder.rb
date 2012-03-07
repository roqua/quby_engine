module Quby
  class QuestionnaireFinder
    class RecordNotFound < StandardError; end

    attr_reader :path
    attr_reader :questionnaire_class

    def initialize(path, questionnaire_class = Questionnaire)
      @path = path
      @questionnaire_class = questionnaire_class
      @questionnaire_cache = {}
    end
    
    def all
      Dir[File.join(@path, "*.rb")].map do |filename|
        key = File.basename(filename, '.rb')
        find(key)
      end
    end

    def find(key)
      if @questionnaire_cache[key]
        return @questionnaire_cache[key]
      else
        if exists?(key)
          definition = File.read(File.join(path, "#{key}.rb"))
          questionnaire = questionnaire_class.new(key, definition)
          @questionnaire_cache[key] = questionnaire
        else
          raise RecordNotFound, key
        end
      end
    end

    def exists?(key)
      path = File.join(@path, "#{key}.rb")
      File.exist?(path)
    end
  end
end
