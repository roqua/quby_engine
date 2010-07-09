class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  after_initialize :enhance_by_dsl

  before_validation(:on => :create) { generate_random_token }

  validates_presence_of :token
  validates_length_of :token, :minimum => 4

  validate :validate_answers

  serialize :value

  def enhance_by_dsl
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
      answer = self.send(question.key)
      validations = question.validations

      if not validations.empty?
        logger.info "Validating #{question.key}."
        question.validations.each do |type, matcher|
          if type == :regexp
            errors.add(question.key, "Does not match #{matcher.inspect}") if not matcher.match(answer)
          end
        end
      end
    end
  end

  protected

  def generate_random_token
    self.token ||= ActiveSupport::SecureRandom.hex(8)
  end

end
