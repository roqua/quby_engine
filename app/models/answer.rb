class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  abefore_validation_on_create :generate_random_token

  validates_presence_of :token
  validates_length_of :token, :minimum => 4

  before_save :validate_answers

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
  
  def validate_answers
    questionnaire.questions.each do |question|
    end
  end

  protected

  def generate_random_token
    self.token ||= ActiveSupport::SecureRandom.hex(8)
  end

end
