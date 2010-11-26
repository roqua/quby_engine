class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  after_initialize :enhance_by_dsl
  before_validation(:on => :create) { generate_random_token }

  validates_presence_of :token
  validates_length_of :token, :minimum => 4
  validate :validate_answers, :on => :update

  attr_accessor :aborted

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

  def clear_question(question)
    value.delete(question.key)
    if question.type == :check_box
      question.options.each do |opt|
        value.delete(opt.key)
      end      
    end
  end

  def completed?
    questionnaire.panels.reduce(true) do |valid_so_far, panel|
      next valid_so_far unless panel
      valid_so_far and panel.validate_answer(self)
    end rescue false
  end

  def validate_answers
    return if @aborted
    questionnaire.questions.each do |question|
      next unless question
      answer = self.send(question.key)
      validations = question.validations
      
      if not validations.empty?
        
        if question.parent and (question.parent.type == :radio and value[question.parent.key] != question.parent_option_key.to_s) or
          (question.parent.type == :check_box and value[question.parent.key][question.parent_option_key] == 0)
          clear_question(question)
          next          
        end
        
        logger.info "Validating #{question.key} = #{question.validations.inspect}."
        
        question.validations.each do |validation|
          case validation[:type]
            
          when :valid_integer
            next if answer.blank?
            begin 
              Integer(answer)
            rescue ArgumentError
              add_error(question, :valid_integer, "Invalid integer")              
            end
          when :valid_float
            next if answer.blank?
            begin
              Float(answer)
            rescue ArgumentError
              add_error(question, :valid_float, "Invalid float")
            end
          when :regexp
            next if answer.blank?
            match = validation[:matcher].match(answer)
            add_error(question, validation[:type], "Does not match pattern expected.") if match and match[0] != answer
          when :requires_answer
            if question.type == :check_box
              add_error(question, validation[:type], "Must be answered.") if answer.values.reduce(:+) == 0
            else 
              add_error(question, validation[:type], "Must be answered.") if answer.blank?
            end            
          when :minimum
            add_error(question, validation[:type], "Smaller than minimum") if not answer.blank? and answer.to_f < validation[:value]
          when :maximum
            add_error(question, validation[:type], "Exceeds maximum") if not answer.blank? and answer.to_f > validation[:value]
          when :too_many_checked
            if self.send(question.uncheck_all_option) == 1 and answer.values.reduce(:+) > 1
              add_error(question, :too_many_checked, "Invalid combination of options.")
            end
          when :not_all_checked
            if self.send(question.check_all_option) == 1 and answer.values.reduce(:+) < answer.length - (question.uncheck_all_option ? 1 : 0)
              add_error(question, :not_all_checked, "Invalid combination of options.")
            end          
          when :one_of
            add_error(question, :one_of, "Not one of the options.") unless validation[:array].include?(answer.to_f)
          end
        end
        logger.info "ERRORS: #{errors.inspect}"
      end      
    end
  end

  protected
  
  def add_error(question, validationtype, message)
    errors.add(question.key, {:message => message, :valtype => validationtype})
  end

  def generate_random_token
    self.token ||= ActiveSupport::SecureRandom.hex(8)
  end

end
