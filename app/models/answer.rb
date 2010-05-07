class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  before_validation_on_create :generate_random_token

  validates_presence_of :token
  validates_length_of :token, :minimum => 4

  serialize :value

  def after_initialize
    AnswerDsl.enhance(self)
  end

  def scores
    scores = {}
    
    questionnaire.scores.map(&:key).each do |k|
      scores[k] = send("score_" + k.to_s)
    end if questionnaire.scores

    scores
  end

  def as_json(options = {})
    super(:methods => [:scores])
  end

  protected

  def generate_random_token
    self.token ||= ActiveSupport::SecureRandom.hex(8)
  end
  
end
