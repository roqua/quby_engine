module QuestionnaireDsl
  def self.enhance(target_instance, definition)
    q = QuestionnaireFactory.new(target_instance)
    q.instance_eval(definition)
  end

  class QuestionnaireFactory
    def initialize(target_instance)
      @questionnaire = target_instance
    end
    
    def question(key, options = {}, &block)
      q = QuestionFactory.new(key, options)
      q.instance_eval(&block)
      
      @questionnaire.instance_eval do
        @questions ||= []
        @questions << q.build
      end
    end
  end
  
  class QuestionFactory
    attr_reader :key
    attr_reader :title
    attr_reader :type
    
    def initialize(key, options = {})
      @question = Question.new(key, options)
    end
    
    def build
      @question
    end
    
    def title(value)
      @question.title = value
    end
    
    def description(value)
      @question.description = value
    end
    
    def option(key, options = {})
      op = QuestionOption.new(key, options)
      @question.options[key] = op
    end
  end
  
end
