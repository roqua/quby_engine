class QuestionOption
  attr_accessor :key
  attr_accessor :value
  attr_accessor :description
  attr_accessor :questions
  attr_accessor :inner_title
  
  def initialize(key, options = {})
    @key         = key
    @value       = options[:value]
    @description = options[:description]
    @questions   = []
    @inner_title = options[:inner_title] 
  end
end
