class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  serialize :value

  def after_initialize
    AnswerDsl.enhance(self)
  end

  def scores
    scores = {}
    questionnaire.scores.map(&:key).each do |k|
      scores[k] = send("score_" + k.to_s)
    end
    scores
  end
  
end
