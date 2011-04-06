class Items::Question < Item
  require 'extensions/maruku_extensions'
  # Standard attributes
  attr_accessor :key
  attr_accessor :title
  attr_accessor :description

  # What kind of question is this?
  attr_accessor :type

  # In what modes do we display this question
  # NOTE We always display questions in print-view (if they have an answer)
  attr_accessor :display_modes

  # Multiple-choice questions have options to choose from
  attr_accessor :options
  
  #Minimum and maximum values for float and integer types
  attr_accessor :minimum
  attr_accessor :maximum
  
  #Whether the browser should autocomplete this question (off by default)
  attr_accessor :autocomplete

  # Whether we show the value for each option
  # true or :all => in all questionnaire display modes
  # false or :none => in none of display modes
  # :paged => for only in :paged display mode
  # :bulk => for only in :bulk display mode
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

  # For quantity items
  attr_accessor :unit
  attr_accessor :size

  #A collection of all questions that can be hidden by all the options of this question
  attr_accessor :hides_questions

  #Whether this radio question is deselectable
  attr_accessor :deselectable

  # Some questions are a tree.
  attr_accessor :parent
  attr_accessor :parent_option_key

  # Whether we can collapse this in bulk view
  attr_accessor :disallow_bulk
  
  # Whether we use the :description, the :value or :none for the score header above this question
  attr_accessor :score_header
 
  #options for grouping questions and setting a minimum or maximum number of answered questions in the group
  attr_accessor :question_group
  attr_accessor :group_minimum_answered
  attr_accessor :group_maximum_answered
  
  #Text variable name that will be replaced with the answer to this question
  #In all following text elements that support markdown
  attr_accessor :text_var

  # Amount of rows a textarea has
  attr_accessor :lines
  
  # Hash to store extra data attributes on the question's html element
  
  # Table this question might belong to
  attr_accessor :table 
  
  ##########################################################
  
  def initialize(key, options = {})
    super(options)
    @key = key
    @type = options[:type]
    @title = options[:title]
    @description = options[:description]
    @display_modes = options[:display_modes]
    @presentation = options[:presentation]
    @validations = []
    @parent = options[:parent]
    @table = options[:table]
    @parent_option_key = options[:parent_option_key]
    @autocomplete = options[:autocomplete] || "off"
    @show_values = options[:show_values] || :bulk
    @check_all_option = options[:check_all_option]
    @uncheck_all_option = options[:uncheck_all_option]
    @deselectable = options[:deselectable] || false
    @disallow_bulk = options[:disallow_bulk]
    @score_header = options[:score_header] || :none
    @text_var = options[:text_var]
    
    @question_group = options[:question_group]
    @group_minimum_answered = options[:group_minimum_answered]
    @group_maximum_answered = options[:group_maximum_answered]
    
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
    
    if @question_group
      if @group_minimum_answered
        @validations << {:type => :answer_group_minimum, :group => @question_group, :value => @group_minimum_answered, :explanation => options[:error_explanation]}
      elsif @group_maximum_answered
        @validations << {:type => :answer_group_maximum, :group => @question_group, :value => @group_maximum_answered, :explanation => options[:error_explanation]}
      end
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
      when :textarea
        { :autocomplete => @autocomplete }
      when :radio
        { :options => @options } 
      when :scale
        { :options => @options }
      when :check_box
        { :options => @options }
      when :quantity
        { :options => @options }
      when :date
        (year_key ? { :year_key => year_key, :month_key => month_key, :day_key => day_key } : {} )
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
