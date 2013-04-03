module Quby
  class QuestionOption
    attr_accessor :key
    attr_accessor :value
    attr_accessor :description
    attr_accessor :questions
    attr_accessor :inner_title
    attr_accessor :hides_questions
    attr_accessor :shows_questions
    attr_accessor :hidden
    attr_accessor :placeholder
    attr_accessor :view_selector

    attr_accessor :start_chosen

    def initialize(key, question, options = {})
      @key         = key
      @value       = options[:value]
      @description = options[:description]
      @questions   = []
      @inner_title = options[:inner_title]
      @hides_questions = options[:hides_questions] || []
      @shows_questions = options[:shows_questions] || []
      @hidden = options[:hidden] || false
      @view_selector = "#answer_#{question.key}_#{key}"
      @placeholder = options[:placeholder] || false
      question.extra_data[:placeholder] = key if @placeholder
      question.options << self
    end

    def to_codebook
      "#{value || key}\t\"#{description}\""
    end
  end
end
