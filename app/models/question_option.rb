class QuestionOption
  attr_accessor :key
  attr_accessor :value
  attr_accessor :description
  attr_accessor :questions
  attr_accessor :inner_title
  attr_accessor :hides_questions
  attr_accessor :hidden
  attr_accessor :placeholder
  
  def initialize(key, question, options = {})
    @key         = key
    @value       = options[:value]
    @description = options[:description]
    @questions   = []
    @placeholder = options[:placeholder] || false
    @inner_title = options[:inner_title]
    @hides_questions = options[:hides_questions] || []
    @hidden = options[:hidden] || false
    question.extra_data[:placeholder] = key if @placeholder
    question.hides_questions = question.hides_questions | @hides_questions
    question.options << self
    
  end

  def to_codebook
    "#{value || key}\t\"#{description}\""
  end
end
