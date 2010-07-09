class Question
  attr_accessor :key
  attr_accessor :title
  attr_accessor :description
  attr_accessor :type
  attr_accessor :options
  attr_accessor :validations
  attr_accessor :dependencies
  
  def initialize(key, options = {})
    @key = key
    @type = options[:type]
    @title = options[:title]
    @description = options[:description]
    @validations = []

    @options = HashWithIndifferentAccess.new
  end

  def subquestions
    options.map {|key, opt| opt.questions }.flatten
  end

end
