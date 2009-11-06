class QuestionOption
  attr_accessor :key
  attr_accessor :value
  attr_accessor :description
  
  def initialize(key, options = {})
    @key         = key
    @value       = options[:value]
    @description = options[:description]
  end
end
