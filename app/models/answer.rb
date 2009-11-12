class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  serialize :value

  def after_initialize
    AnswerDsl.enhance(self)
  end
  
end
