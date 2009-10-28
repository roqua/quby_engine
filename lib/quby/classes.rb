module Quby


  class Question
    attr_accessor :key
    attr_accessor :title
    attr_accessor :description
    attr_accessor :type
    attr_accessor :options

    def initialize(key, options = {})
      @key = key
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
