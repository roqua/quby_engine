class Items::Question < Item
  require 'extensions/maruku_extensions'
  # Standard attributes
  attr_accessor :key
  attr_accessor :title
  attr_accessor :description

  # What kind of question is this?
  attr_accessor :type

  # To hide old questions
  attr_accessor :hidden

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

  # For optionally giving year, month and day fields of dates their own keys
  attr_accessor :year_key
  attr_accessor :month_key
  attr_accessor :day_key

  # To display unit for number items
  attr_accessor :unit
  # To specify size of string/number input boxes
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

  # This question should not validate itself unless the depends_on question is answered
  # May also be an array of "#{question_key}_#{option_key}" strings that specify options this question depends on
  attr_accessor :depends_on  

  # Extra data hash to store on the question item's html element
  attr_accessor :extra_data

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

  # Table this question might belong to
  attr_accessor :table
  
  #In case of being displayed inside a table, amount of columns/rows to span
  attr_accessor :col_span
  attr_accessor :row_span

  ##########################################################

  def initialize(key, options = {})
    super(options)
    @extra_data ||= {}
    @options = []
    @key = key
    @type = options[:type]
    @title = options[:title]
    @description = options[:description]
    @display_modes = options[:display_modes]
    @presentation = options[:presentation]
    @validations = []
    @parent = options[:parent]
    @hidden = options[:hidden]
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
    @unit = options[:unit]
    
    @col_span = options[:col_span] || 1
    @row_span = options[:row_span] || 1
    
    set_depends_on(options[:depends_on], options[:questionnaire])

    @question_group = options[:question_group]
    @group_minimum_answered = options[:group_minimum_answered]
    @group_maximum_answered = options[:group_maximum_answered]

    @year_key = options[:year_key].andand.to_s
    @month_key = options[:month_key].andand.to_s
    @day_key = options[:day_key].andand.to_s

    #Require subquestions of required questions by default
    options[:required] = true if @parent.andand.validations.andand.first.andand.type == :requires_answer 
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
      end
      if @group_maximum_answered
        @validations << {:type => :answer_group_maximum, :group => @question_group, :value => @group_maximum_answered, :explanation => options[:error_explanation]}
      end
    end

    @hides_questions = []    
  end
  
  def set_depends_on(keys, questionnaire)
    return if keys.blank?
    keys = [keys] unless keys.is_a?(Array)
    input_keys = questionnaire.get_input_keys(keys)
    @depends_on = input_keys
    @extra_data[:depends_on] = input_keys.to_json
  end
  
  def depends_on
    @depends_on
  end

  def as_json(options = {})
    super.merge({
      :key => key,
      :title => title,
      :description => description,
      :type => type,
      :validations => validations,
      :unit => unit,
      :hidden => !!hidden?
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
      when :select
        { :options => @options }
      when :check_box
        { :options => @options }
      when :date
        (year_key ? { :year_key => year_key, :month_key => month_key, :day_key => day_key } : {} )
      when :hidden
        { :options => @options }
      else
        {}
      end
    )
  end

  def html_id
    "answer_#{key}_input"
  end

  def answerable?; true; end

  def hidden?
    self.type == :hidden or self.hidden
  end

  def subquestions
    options.map {|opt| opt.questions }.flatten
  end

  def validate_answer(answer_hash)
    false
  end

  def to_codebook(questionnaire, opts = {})
    output = []
    output_type = type
    output_type = :radio if [:scale, :select].include?(output_type)

    output_range = ""
    range_min = validations.find{|i| i[:type] == :minimum}.andand[:value]
    range_max = validations.find{|i| i[:type] == :maximum}.andand[:value]
    output_range = "(#{[range_min, "value", range_max].compact.join(" <= ")})" if range_min || range_max

    case type
    when :date
      if day_key
        output_key = day_key.to_s.gsub(/^v_/, "#{opts[:roqua_key] || questionnaire.key.to_s}_")
        output << "#{output_key} #{output_type}_day #{output_range}"
        output << "\"#{title}\"" unless title.blank?
        output << options.map(&:to_codebook).join("\n") unless options.blank?
        output << ""
      end
      
      if month_key
        output_key = month_key.to_s.gsub(/^v_/, "#{opts[:roqua_key] || questionnaire.key.to_s}_")
        output << "#{output_key} #{output_type}_month #{output_range}"
        output << "\"#{title}\"" unless title.blank?
        output << options.map(&:to_codebook).join("\n") unless options.blank?
        output << ""
      end
      
      if year_key
        output_key = year_key.to_s.gsub(/^v_/, "#{opts[:roqua_key] || questionnaire.key.to_s}_")
        output << "#{output_key} #{output_type}_year #{output_range}"
        output << "\"#{title}\"" unless title.blank?
        output << options.map(&:to_codebook).join("\n") unless options.blank?
        output << ""
      end

      if not (year_key or month_key or day_key)
        output_key = key.to_s.gsub(/^v_/, "#{opts[:roqua_key] || questionnaire.key.to_s}_")
        output << "#{output_key} #{output_type}_day #{output_range}"
        output << "\"#{title}\"" unless title.blank?
        output << options.map(&:to_codebook).join("\n") unless options.blank?
      end
    when :check_box
      options.each_with_index do |option, idx|
        output_key = option.key.to_s.gsub(/^v_/, "#{opts[:roqua_key] || questionnaire.key.to_s}_")
        output << "#{output_key} #{output_type}"
        output << "\"#{title}\"" unless title.blank?
        output << "1\tChecked"
        output << "0\tUnchecked"
        output << "empty\tUnchecked"
        output << "" unless idx == (options.size-1)
      end
    else
      output_key = key.to_s.gsub(/^v_/, "#{opts[:roqua_key] || questionnaire.key.to_s}_")
      output << "#{output_key} #{output_type} #{output_range}"
      output << "\"#{title}\"" unless title.blank?
      output << options.map(&:to_codebook).join("\n") unless options.blank?
    end

    output.join("\n")
  end

end
