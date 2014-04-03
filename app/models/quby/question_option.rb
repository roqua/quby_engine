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
    attr_accessor :question
    attr_accessor :view_id

    attr_accessor :start_chosen

    def initialize(key, question, options = {})
      @key         = key
      @question    = question
      @value       = options[:value]
      @description = options[:description]
      @questions   = []
      @inner_title = options[:inner_title]
      @hides_questions = options[:hides_questions] || []
      @shows_questions = options[:shows_questions] || []
      @hidden = options[:hidden] || false
      @view_id = "answer_#{input_key}"
      @placeholder = options[:placeholder] || false
      question.extra_data[:placeholder] = key if @placeholder
    end

    def input_key
      question.type == :check_box ? @key : "#{question.key}_#{key}".to_sym
    end

    def inner_title?
      inner_title.present?
    end

    def key_in_use?(k)
      return true if k == input_key
      @questions.each { |q| return true if q.key_in_use?(k) }
      false
    end

    def as_json(options = {})
      super.symbolize_keys.except(:question)
    end

    def to_codebook
      "#{value || key}\t\"#{description}\""
    end
  end
end
