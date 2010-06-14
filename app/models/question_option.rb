class QuestionOption
  attr_accessor :key
  attr_accessor :value
  attr_accessor :description
  attr_accessor :questions
  
  def initialize(key, options = {})
    @key         = key
    @value       = options[:value]
    @description = options[:description]
    @questions   = []
  end
end
