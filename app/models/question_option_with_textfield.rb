class QuestionOptionWithTextfield
  attr_accessor :key
  attr_accessor :value
  attr_accessor :description
  
  def initialize(key, options = {})
    @key         = key
    @description = options[:description]
  end
end
