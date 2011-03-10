class QuestionOption
  attr_accessor :key
  attr_accessor :value
  attr_accessor :description
  attr_accessor :questions
  attr_accessor :inner_title
  attr_accessor :hides_questions
  attr_accessor :hidden
  
  def initialize(key, question, options = {})
    @key         = key
    @value       = options[:value]
    @description = options[:description]
    @questions   = []
    @inner_title = options[:inner_title]
    @hides_questions = options[:hides_questions] || []
    @hidden = options[:hidden] || false
    question.hides_questions = question.hides_questions | @hides_questions 
    question.options << self
  end
end
