class Items::Question < Item
  # Standard attributes
  attr_accessor :key
  attr_accessor :title
  attr_accessor :description

  # What kind of question is this?
  attr_accessor :type

  # Multiple-choice questions have options to choose from
  attr_accessor :options
  
  #Minimum and maximum values for float and integer types
  attr_accessor :minimum
  attr_accessor :maximum
  
  #Whether the browser should autocomplete this question (off by default)
  attr_accessor :autocomplete

  # Whether we show the value for each option
  attr_accessor :show_values
  
  #checkbox option that checks all other options on check
  attr_accessor :check_all_option
  #checkbox option that unchecks all other options on check
  attr_accessor :uncheck_all_option 
  
  # Structuring
  attr_accessor :validations
  attr_accessor :dependencies

  #For optionally giving year, month and day fields their own keys
  attr_accessor :year_key
  attr_accessor :month_key
  attr_accessor :day_key

  #A collection of all questions that can be hidden by all the options of this question
  attr_accessor :hides_questions

  # Some questions are a tree.
  attr_accessor :parent
  attr_accessor :parent_option_key
 
  ##########################################################
  
  def initialize(key, options = {})
    @key = key
    @type = options[:type]
    @title = options[:title]
    @description = options[:description]
    @presentation = options[:presentation]
    @validations = []
    @parent = options[:parent]
    @parent_option_key = options[:parent_option_key]
    @autocomplete = options[:autocomplete] || "off"
    @show_values = options[:show_values]
    @check_all_option = options[:check_all_option] 
    @uncheck_all_option = options[:uncheck_all_option]    
    
    @year_key = options[:year_key].andand.to_s
    @month_key = options[:month_key].andand.to_s
    @day_key = options[:day_key].andand.to_s
    
    @validations << {:type => :requires_answer, :explanation => options[:error_explanation]} if options[:required]
    
    if @type == :float
      @validations << {:type => :valid_float, :explanation => options[:error_explanation]}
    elsif @type == :integer
      @validations << {:type => :valid_integer, :explanation => options[:error_explanation]}
    end
    
    if options[:minimum] and (@type == :integer or @type == :float)
      @validations << {:type => :minimum, :value => options[:minimum], :explanation => options[:error_explanation]}
    end
    if options[:maximum] and (@type == :integer or @type == :float)
      @validations << {:type => :maximum, :value => options[:maximum], :explanation => options[:error_explanation]}
    end
    
    if @check_all_option
      @validations << {:type => :not_all_checked, :check_all_key => @check_all_option, :explanation => options[:error_explanation]}
    end
    if @uncheck_all_option
      @validations << {:type => :too_many_checked, :uncheck_all_key => @uncheck_all_option, :explanation => options[:error_explanation]}
    end
    
    @hides_questions = []
    @options = []
  end

  def as_json(options = {})
    super.merge({
      :key => key,
      :title => title,
      :description => description,
      :type => type,
    }).merge(
      case type
      when :string
        { :autocomplete => @autocomplete }
      when :radio
        { :options => @options } 
      when :scale
        { :options => @options }
      when :check_box
        { :options => @options } 
      else
        {}
      end
    )
  end

  def answerable?; true; end

  def subquestions
    options.map {|opt| opt.questions }.flatten
  end

  def validate_answer(answer_hash)
    false
  end

end
