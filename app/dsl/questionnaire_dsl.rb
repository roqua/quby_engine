module QuestionnaireDsl
  def self.enhance(target_instance, definition)
    q = QuestionnaireFactory.new(target_instance)
    q.instance_eval(definition)
  end

  class QuestionnaireFactory
    def initialize(target_instance)
      @questionnaire = target_instance
    end


    def name(name)
      @questionnaire.name = name
    end
    
    def panel(title = nil, options = {}, &block)
      p = PanelFactory.new(title, options)
      p.instance_eval(&block)
      
      @questionnaire.instance_eval do
        @panels ||= []
        @panels << p.build
      end
    end
    
    def question(key, options = {}, &block)
      panel() do
        question(key, options, &block)
      end
    end

    # score :totaal do
    #   q01 + q02 + q03
    # end
    def score(key, options = {}, &block)
      s = ScoreFactory.new(key, options, &block)

      @questionnaire.instance_eval do
        @scores ||= []
        @scores << s.build
      end
    end
  end

  class PanelFactory
    attr_reader :title

    def initialize(title, options = {})
      @panel = {:title => title,
                :items => []}
    end

    def build
      @panel
    end

    def title(value)
      @panel[:title] = value
    end

    def text(value)
      @panel[:items] << value.to_s
    end

    def question(key, options = {}, &block)
      q = QuestionFactory.new(key, options)
      q.instance_eval(&block)

      @panel[:items] << q.build
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
  
  class ScoreFactory
    attr_reader :key
    attr_reader :scorer

    def initialize(key, options = {}, &block)
      @score = Score.new(key, options, &block)
    end

    def build
      @score
    end
  end
    
end
