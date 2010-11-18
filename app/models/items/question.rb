class Items::Question < Item
  # Standard attributes
  attr_accessor :key
  attr_accessor :title
  attr_accessor :description

  # What kind of question is this?
  attr_accessor :type

  # Multiple-choice questions have options to choose from
  attr_accessor :options
  
  #Whether the browser should autocomplete this question (off by default)
  attr_accessor :autocomplete
  
  #checkbox option that checks all other options on check
  attr_accessor :check_all_option
  #checkbox option that unchecks all other options on check
  attr_accessor :uncheck_all_option 
  
  # Structuring
  attr_accessor :validations
  attr_accessor :dependencies

  # Some questions are a tree.
  attr_accessor :parent
  attr_accessor :parent_option_key
 
  ##########################################################
  #
  def initialize(key, options = {})
    @key = key
    @type = options[:type]
    @title = options[:title]
    @description = options[:description]
    @validations = []
    @parent = options[:parent]
    @parent_option_key = options[:parent_option_key]
    @autocomplete = options[:autocomplete] || false
    @check_all_option = options[:check_all_option] || nil
    @uncheck_all_option = options[:uncheck_all_option] || nil    
    
    @options = []
  end

  def answerable?; true; end

  def subquestions
    options.map {|opt| opt.questions }.flatten
  end

  def validate_answer(answer_hash)
    false
  end

end
