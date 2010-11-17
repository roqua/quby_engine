class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  after_initialize :enhance_by_dsl
  before_validation(:on => :create) { generate_random_token }

  validates_presence_of :token
  validates_length_of :token, :minimum => 4
  validate :validate_answers, :on => :update

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
    attributes.merge({
      :scores => self.scores,
      :is_completed => self.completed? ? true : false
    })
  end

  def completed?
    questionnaire.panels.reduce(true) do |valid_so_far, panel|
      next valid_so_far unless panel
      valid_so_far and panel.validate_answer(self)
    end rescue false
  end

  def validate_answers
    questionnaire.questions.each do |question|
      next unless question
      answer = self.send(question.key)
      validations = question.validations

      if not validations.empty?
        logger.info "Validating #{question.key} = #{question.validations.inspect}."
        
        next if question.parent and value[question.parent.key] != question.parent_option_key
        
        question.validations.each do |validation|
          case validation[:type]
          when :regexp
            errors.add(question.key, "Does not match pattern expected.") if not validation[:matcher].match(answer)
          when :requires_answer
            if question.type == :check_box
              errors.add(question.key, "Must be answered.") if answer.values.reduce(:+) == 0
            else 
              errors.add(question.key, "Must be answered.") if answer.blank?
            end            
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
