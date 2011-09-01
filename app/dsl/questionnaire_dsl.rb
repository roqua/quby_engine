module QuestionnaireDsl
  def self.enhance(target_instance, definition)
    q = QuestionnaireFactory.new(target_instance)
    q.instance_eval(definition)
  end

  class QuestionnaireFactory
    def initialize(target_instance)
      @questionnaire = target_instance
      @default_question_options = {}
    end

    def leave_page_alert(text)
      @questionnaire.leave_page_alert = text
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
    
    def outcome_description(description)
      @questionnaire.outcome_description = description
    end
    
    def short_description(description)
      @questionnaire.short_description = description
    end
    
    def abortable
      @questionnaire.abortable = true 
    end
    
    def allow_hotkeys(type = :all)
      @questionnaire.allow_hotkeys = type
    end
    
    def enable_previous_questionnaire_button
      @questionnaire.enable_previous_questionnaire_button = true
    end
    
    def css(value)
      @questionnaire.extra_css ||= ""
      @questionnaire.extra_css += value
    end

    def default_answer_value(value)
      @questionnaire.default_answer_value = value
    end
    
    def panel(title = nil, options = {}, &block)
      p = PanelFactory.new(title, options.merge(default_panel_options))
      p.instance_eval(&block)
      
      @questionnaire.instance_eval do
        @panels ||= []
        @panels << p.build
      end
    end

    def default_question_options(options = {})
      @default_question_options.merge!(options)
    end

    # Short-circuit the question command to perform an implicit panel
    def question(key, options = {}, &block)
      panel(nil, default_panel_options) do
        question(key, default_question_options(options.merge({:questionnaire => @questionnaire})), &block)
      end
    end

    # Short-circuit the text command to perform an implicit panel
    def text(value, options = {})
      panel(nil, default_panel_options) do
        text(value, options)
      end
    end
    
    # Short-circuit the table command to perform an implicit panel
    def table(options = {}, &block)
      panel(nil, default_panel_options) do
        table(options, &block)
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
    
    private
    def default_panel_options
      {:questionnaire => @questionnaire, :default_question_options => @default_question_options}
    end
  end

  class PanelFactory
    attr_reader :title
    attr_reader :questionnaire
    
    def initialize(title, options = {})
      @panel = Items::Panel.new(options.merge({:title => title, :items => []}))
      @default_question_options = options[:default_question_options] || {}
      @questionnaire = options[:questionnaire]
    end

    def build
      @panel
    end

    def title(value)
      @panel.title = value
    end

    def text(value, options = {})
      @panel.items << Items::Text.new(value.to_s, options)
    end
    
    def html(value)
      @panel.items << Items::Text.new('', :html_content => value.to_s)
    end
    
    def raw_html(value)
      @panel.items << Items::Text.new('', :raw_content => value.to_s)
    end
    
    def default_question_options(options = {})
      @default_question_options = @default_question_options.merge(options)
    end
    
    def question(key, options = {}, &block)
      raise "Question key: #{key} repeated!" if @questionnaire.question_hash[key]
      
      q = QuestionFactory.new(key, @default_question_options.merge(options).merge({:questionnaire => @panel.questionnaire}))
      @questionnaire.question_hash[key] = q.build
      q.instance_eval(&block) if block
      
      @panel.items << q.build
    end
    
    def table(options = {}, &block)
      t = TableFactory.new(@panel, options.merge({:questionnaire => @panel.questionnaire, :default_question_options => @default_question_options}))
      t.instance_eval(&block) if block
    end
    
  end
  
  class TableFactory
    
    def initialize(panel, options = {})
      @panel = panel
      @table = Items::Table.new(options) 
      @default_question_options = options[:default_question_options] || {}
      @panel.items << @table
    end
    
    def title(value)
      @table.title = value
    end
    
    def description(value)
      @table.description = value
    end
    
    def text(value, options = {})
      t = Items::Text.new(value.to_s, options)
      @table.items << t 
    end
    
    def question(key, options = {}, &block)
      raise "Question key: #{key} repeated!" if @panel.questionnaire.question_hash[key]
            
      q = QuestionFactory.new(key, @default_question_options.merge(options).merge(:table => @table, :questionnaire => @panel.questionnaire))
      @panel.questionnaire.question_hash[key] = q.build
      q.instance_eval(&block) if block

      @table.items << q.build      
      @panel.items << q.build
    end
  end
  
  class QuestionFactory
    attr_reader :key
    attr_reader :title
    attr_reader :type
    attr_reader :parent
    attr_reader :questionnaire
    
    def initialize(key, options = {})
      @question = Items::Question.new(key, options)      
      @default_question_options = options[:default_question_options] || {}
      @questionnaire = options[:questionnaire]
      @title_question = nil
    end
    
    def build
      if @title_question
        @question.options.last.questions << @title_question
        @title_question = nil
      end
      @question
    end
    
    def title(value)
      @question.title = value
    end
    
    def inner_title(value)
      op = QuestionOption.new(nil, @question, :inner_title => true, :description => value)      
    end
    
    def description(value)
      @question.description = value
    end

    def presentation(value)
      @question.presentation = value
    end

    def hidden(value = true)
      @question.hidden = value
    end

    def lines(value)
      @question.lines = value
    end

    def unit(value)
      @question.unit = value
    end
    
    def size(value)
      @question.size = value
    end
    
    def option(key, options = {}, &block)
      raise "Option with key #{key} already defined. Keys must be unique within a question." if @question.options.find {|i| i.key == key }
      raise "Question with key #{key} already defined. Checkbox option keys must be completely unique." if @question.type == :check_box && @questionnaire.question_hash[key]
      
      op = QuestionOption.new(key, @question, options)

      instance_eval &block if block
    end
    
    def title_question(key, options = {}, &block)
      raise "Question key: #{key} repeated!" if @questionnaire.question_hash[key]
      options = @default_question_options.merge({:depends_on => @question.key, :questionnaire => @questionnaire, :parent => @question, :presentation => :next_to_title}.merge(options))
      
      q = QuestionFactory.new(key, options)
      q.instance_eval(&block) if block
      @questionnaire.question_hash[key] = q.build
      @title_question = q.build
    end

    def question(key, options = {}, &block)
      raise "Question key: #{key} repeated!" if @questionnaire.question_hash[key]
      
      q = QuestionFactory.new(key, @default_question_options.merge(options.merge({:questionnaire => @questionnaire, :parent => @question, :parent_option_key => @question.options.last.key})))
      q.instance_eval(&block) if block
      @questionnaire.question_hash[key] = q.build
      @question.options.last.questions << q.build
    end

    def depends_on(keys)
      @question.set_depends_on(keys, @questionnaire)
    end

    def validates_format_with(regexp, options = {})
      @question.validations ||= []
      @question.validations << {:type => :regexp, :matcher => regexp}.reverse_merge(options)
    end

    def validates_presence_of_answer(options = {})
      @question.validations ||= []
      @question.validations << {:type => :requires_answer}.reverse_merge(options)
    end
    
    def validates_minimum(value, options = {})
      @question.validations ||= []
      @question.validations << {:type => :minimum, :value => value}.reverse_merge(options)
    end
    
    def validates_maximum(value, options = {})
      @question.validations ||= []
      @question.validations << {:type => :maximum, :value => value}.reverse_merge(options)
    end
    
    def validates_in_range(range, options = {})
      @question.validations ||= []
      @question.validations << {:type => :minimum, :value => range.first}.reverse_merge(options)
      @question.validations << {:type => :maximum, :value => range.last}.reverse_merge(options)
    end
    
    def validates_one_of(array, options = {})
      @question.validations ||= []
      @question.validations << {:type => :one_of, :array => array}.reverse_merge(options)
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
