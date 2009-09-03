module Quby

  class Questionnaire < ActiveRecord::Base
    attr_accessor :key
    attr_accessor :questions
    
    set_table_name "questionnaires"
    
    def to_json
      # TODO
    end
    
    def self.question(key, options = {}, &block)
      q = Quby::Factories::QuestionFactory.new(key, options)
      q.instance_eval(&block)
      @questions ||= []
      @questions << q.build
    end
    
    def self.questions
      @questions
    end
    
  end

  class Question
    attr_accessor :key
    attr_accessor :title
    attr_accessor :description
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
