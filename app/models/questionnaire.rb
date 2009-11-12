class Questionnaire < ActiveRecord::Base
  has_many :answers

  before_save :validate_definition_syntax

  attr :questions
  
  def after_initialize
   QuestionnaireDsl.enhance(self, self.definition || "")
  end

  protected

  def validate_definition_syntax
    q = Questionnaire.new
    begin
#     raise "Boom!"
      QuestionnaireDsl.enhance(q, self.definition)
    rescue => e
      errors.add(:definition, "Syntax error")
      errors.add(:definition, e.message)
      errors.add(:definition, e.backtrace[0..5].join("<br/>"))
      return false
    end
    return true
  end
  
end
