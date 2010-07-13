class Question
  # Standard attributes
  attr_accessor :key
  attr_accessor :title
  attr_accessor :description

  # What kind of question is this?
  attr_accessor :type

  # Multiple-choice questions have options to choose from
  attr_accessor :options

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

    @options = HashWithIndifferentAccess.new
  end

  def subquestions
    options.map {|key, opt| opt.questions }.flatten
  end

end
