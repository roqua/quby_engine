module QuestionnaireDsl
  def self.enhance(target_instance, definition)
    q = QuestionnaireFactory.new(target_instance)
    q.instance_eval(definition)
  end

  class QuestionnaireFactory
    def initialize(target_instance)
      @questionnaire = target_instance
    end


    def key(key)
      # @questionnaire.key = key
    end

    def title(title)
      @questionnaire.title = title
    end

    def description(description)
      @questionnaire.description = description
    end
    
    def panel(title = nil, options = {}, &block)
      p = PanelFactory.new(title, options)
      p.instance_eval(&block)
      
      @questionnaire.instance_eval do
        @panels ||= []
        @panels << p.build
      end
    end

    # Short-circuit the question command to perform an implicit panel
    def question(key, options = {}, &block)
      panel() do
        question(key, options, &block)
      end
    end

    # Short-circuit the text command to perform an implicit panel
    def text(value)
      panel() do
        text(value)
      end
    end
    
    # score :totaal do
    #   # Plain old Ruby code here, executed in the scope of the answer
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
      # TODO Add check for repeated use of keys
      
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
      raise "Option with key #{key} already defined. Keys must be unique with a question." if @question.options[:key]
      
      op = QuestionOption.new(key, options)
      @question.options[key] = op
    end

    def other(key, options = {})
      raise "Option with key #{key} already defined. Keys must be unique with a question." if @question.options[:key]
      
      op = QuestionOptionWithTextfield.new(key, options)
      @question.options[key] = op
    end

    def dependencies(options = {}, &block)
      dependency = DependencyFactory.new(options)
      dependency.instance_eval(&block)

      @question.dependencies << dependency
    end      
  end

  class DependencyFactory
    # dependencies do
    #   question :q03, :is_valid
    #   question :q04, :in => [:q04a04, :q04a05]
    # end
    
    def initialize(options = {})
      @dependency = Dependency.new(options)
    end

    def question(question_key, options = {})
      # TODO
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
