class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  after_initialize :enhance_by_dsl
  before_validation(:on => :create) { generate_random_token }

  validates_presence_of :token
  validates_length_of :token, :minimum => 4
  validate :validate_answers, :on => :update

  attr_accessor :aborted
  #Values in globalpark coding that need to be recoded and used to initialize this answer
  attr_accessor :roqua_vals

  serialize :value

  def enhance_by_dsl
    AnswerDsl.enhance(self)
    
    if @roqua_vals
      @questionnaire.questions.each do |q|
        case q.type 
        when :radio
          q.options.each do |opt|
            if opt.value.to_s == @roqua_vals[q.key]
              @roqua_vals[q.key] = opt.key
            end
          end
        when :check_box
          q.options.each do |opt|
            if @roqua_vals[opt.key] != "1"
              @roqua_vals.delete(opt.key)
            end
          end
        end
      end
      logger.info "RECODED VALUES: #{@roqua_vals.inspect}"
      @roqua_vals.each_pair do |key, value|
        self.send("#{key}=", value)
      end
      @roqua_vals = nil
    end
  end

  def scores
    scores = {}
    questionnaire.scores.map(&:key).each do |k|
      scores[k] = send("score_" + k.to_s)
    end if questionnaire.scores
    scores
  end

  def as_json(options = {})
    begin
      if value
        value_by_values = value.dup
        value.each_key do |key|
          #logger.debug "Finding questionnaire #{questionnaire.key} question with key #{key}"
          question = questionnaire.questions.find(){|q| q.andand.key == key }
          #logger.debug question.inspect
          if question and (question.type == :radio || question.type == :scale)
            #logger.debug "Question is a radio"
            option   = question.options.find(){|o| o.key.to_s == value[key].to_s }
            #logger.debug option.inspect
            if option 
              value_by_values[key] = option.value.to_s
            end
          end
        end
      end
    rescue Exception => e
      logger.error "RESCUED #{e.message} \n #{e.backtrace.join('\n')}"
    end

    attributes.merge({
      :value_by_values => value_by_values,
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
#    questionnaire.panels.reduce(true) do |valid_so_far, panel|
#      next valid_so_far unless panel
#      valid_so_far and panel.validate_answer(self)
#    end rescue false
    valid?
  end

  def validate_answers
    return if @aborted
    hidden_questions = []
    question_groups = {}
    
    questionnaire.questions.each do |q|
      next unless q
      if q.question_group
        question_groups[q.question_group] = [] unless question_groups[q.question_group]
        question_groups[q.question_group] << q.key
      end
    end
    
    questionnaire.questions.each do |question|
      next unless question
      answer = self.send(question.key)
      validations = question.validations

      if answer and question.type == :radio and not question.hides_questions.blank?
        question.options.each do |opt|
          if answer.to_sym == opt.key
            hidden_questions.concat(opt.hides_questions)
          end
        end
      end
      
      if (question.parent and (question.parent.type == :radio and value[question.parent.key] != question.parent_option_key.to_s) or
          (question.parent.type == :check_box and value[question.parent.key][question.parent_option_key] == 0)) or
          hidden_questions.include?(question.key) or
          answer == "DESELECTED_RADIO_VALUE" 
        clear_question(question) 
        next          
      end
      
      if not validations.empty?
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
            add_error(question, validation[:type], "Does not match pattern expected.") if not match or match[0] != answer
          when :requires_answer
            next if hidden_questions.include?(question.key)
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
            if self.send("#{question.key}_#{question.uncheck_all_option}") == 1 and answer.values.reduce(:+) > 1
              add_error(question, :too_many_checked, "Invalid combination of options.")
            end
          when :not_all_checked
            if self.send("#{question.key}_#{question.check_all_option}") == 1 and answer.values.reduce(:+) < answer.length - (question.uncheck_all_option ? 1 : 0)
              add_error(question, :not_all_checked, "Invalid combination of options.")
            end          
          when :one_of
            add_error(question, :one_of, "Not one of the options.") if not answer.blank? and not validation[:array].include?(answer.to_f)
          when :answer_group_minimum
            answered = calc_answered(question_groups[validation[:group]])
            if answered < validation[:value]
              add_error(question, :answer_group_minimum, "Needs at least #{validation[:value]} question(s) answered.")
            end
          when :answer_group_maximum
            answered = calc_answered(question_groups[validation[:group]])
            if answered > validation[:value]
              add_error(question, :answer_group_maximum, "Needs at most #{validation[:value]} question(s) answered.")
            end
          end
        end
        logger.info "ERRORS: #{errors.inspect}"
      end      
    end
  end

  protected
  
  def calc_answered(qkeys)
    answered = 0
    qkeys.each do |qk|
      unless self.send(qk).blank?
        answered += 1
      end
    end
    return answered
  end
  
  def add_error(question, validationtype, message)
    errors.add(question.key, {:message => message, :valtype => validationtype})
  end

  def generate_random_token
    self.token ||= ActiveSupport::SecureRandom.hex(8)
  end

end
