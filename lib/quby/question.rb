module Quby

  class Questionnaire
    attr_accessor :key
    attr_accessor :questions
    
    def initialize(key, options = {})
      @key = key
      @questions = []
    end

    def to_json
      # TODO
    end
  end

  class Question
    attr_accessor :title
    attr_accessor :description
    attr_accessor :options

    def initialize(str, options = {})
      @str = str
      @type = options[:type]
      @options = []
    end
  end

  class QuestionOption
    attr_accessor :key
    attr_accessor :value
    attr_accessor :description

    def initialize(key, options = {})
      @key         = key
      @value       = options[:value]
      @description = options[:description]
    end
  end

end
