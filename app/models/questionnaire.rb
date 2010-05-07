class Questionnaire < ActiveRecord::Base
  has_many :answers

  before_save :validate_definition_syntax

  has_paper_trail

  attr_accessor :title
  attr_accessor :description
  attr_accessor :panels
  
  def after_initialize
    functions = Function.all.map(&:definition).join("\n\n")
    functions_and_definition = [functions, self.definition].join("\n\n")
    QuestionnaireDsl.enhance(self, functions_and_definition || "")
  end

  def questions
    @panels.map do |panel|
      panel[:items].select {|item| Question === item }
    end.flatten
  end

  def scores
    @scores
  end

  protected

  def validate_definition_syntax
    q = Questionnaire.new
    begin
#     raise "Boom!"
      functions = Function.all.map(&:definition).join("\n\n")
      QuestionnaireDsl.enhance(q, [functions, self.definition].join("\n\n"))
    rescue => e
      errors.add(:definition, "Syntax error")
      errors.add(:definition, e.message)
      errors.add(:definition, e.backtrace[0..5].join("<br/>"))
      return false
    end
    return true
  end
  
end
