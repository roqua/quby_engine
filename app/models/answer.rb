class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  identity type: String
  field :questionnaire_id,  :type => Integer
  field :value,             :type => Hash
  field :patient_id,        :type => String
  field :token,             :type => String
  field :active,            :type => Boolean, :default => true
  field :test,              :type => Boolean, :default => false

  # Faux belongs_to :questionnaire
  def questionnaire; Questionnaire.find(questionnaire_id); end

  def self.find_or_create_by_test_and_questionnaire_id(options = {})
    if answer = where(:test => options[:test], :questionnaire_id => options[:questionnaire_id]).first
      return answer
    else
      create(options)
    end
  end

  after_initialize :enhance_by_dsl
  before_validation(:on => :create) { generate_random_token }
  before_validation(:on => :update) { cleanup_input }
  before_save { self[:value_by_values] = value_by_values }
  validates_presence_of :token
  validates_length_of :token, :minimum => 4
  validate :validate_answers, :on => :update

  attr_accessor :aborted
  #Values in globalpark coding that need to be recoded and used to initialize this answer
  attr_accessor :roqua_vals

  #for setting raw content values and failed validations
  attr_accessor :extra_question_values
  attr_accessor :extra_failed_validations

  #for setting which questions should be hidden
  attr_accessor :to_hide

  def enhance_by_dsl
    AnswerDsl.enhance(self)

    questionnaire.questions.each do |question|
      next unless question
      if question.text_var
        Maruku.setTextVar(question.text_var, self.send(question.key))
      end rescue nil
    end
  end

  def extra_question_values
    @extra_question_values = {}
    questionnaire.questions.each do |q|
      next unless q
      unless q.raw_content.blank?
        @extra_question_values[q.key] = self.send(q.key)
      end
    end

    @extra_question_values.to_json
  end

  def extra_failed_validations
    @extra_failed_validations = {}
    questionnaire.questions.each do |q|
      next unless q
      unless q.raw_content.blank?
        @extra_failed_validations[q.key] = errors[q.key] if errors[q.key] and not errors[q.key].blank?
      end
    end
    @extra_failed_validations.to_json
  end

  def scores
    questionnaire.scores.map(&:key).map do |key|
      val = send("score_" + key.to_s)
      val[:key] = key
      val
    end if questionnaire.scores
  rescue Exception => e
    {
      :exception_message => e.message,
      :exception_backtrace => e.backtrace
    }
  end

  def value_by_values
    if value
      result = value.dup
      value.each_key do |key|
        question = questionnaire.questions.find(){|q| q.andand.key.to_s == key }
        if question and (question.type == :radio || question.type == :scale || question.type == :select)
          option = question.options.find(){|o| o.key.to_s == value[key].to_s }
          if option
            result[key] = option.value
          end
        end
      end
    end
    result
  rescue Exception => e
    logger.error "RESCUED #{e.message} \n #{e.backtrace.join('\n')}"
    {}
  end

  def as_json(options = {})
    begin
      if value
        value_by_values = value.dup
        value.each_key do |key|
          question = questionnaire.questions.find(){|q| q.andand.key == key }
          if question and (question.type == :radio || question.type == :scale || question.type == :select)
            option = question.options.find(){|o| o.key.to_s == value[key].to_s }

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
      :id => self.id,
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

    all_blank = questionnaire.questions.reduce(true) do |all_blank, question|
      next all_blank unless question
      all_blank and self.send(question.key).blank?
    end

    not all_blank and valid?
  end

  def cleanup_input
    @hidden_questions = []
    @question_groups = {}

    questionnaire.questions.each do |question|
      next unless question
      answer = self.send(question.key)
      if answer and (answer == "DESELECTED_RADIO_VALUE" or answer == question.extra_data[:placeholder].to_s)
        clear_question(question)
      end

      if answer and [:radio, :scale].include?(question.type) and not question.hides_questions.blank?
        question.options.each do |opt|
          if answer.to_sym == opt.key
            @hidden_questions.concat(opt.hides_questions)
          end
        end
      end

      if question.question_group
        @question_groups[question.question_group] = [] unless @question_groups[question.question_group]
        @question_groups[question.question_group] << question.key
      end

    end
  end

  def validate_answers
    return if @aborted

    questionnaire.questions.each do |question|
      next unless question
      next if question.type == :hidden or question.hidden?

      if (question.parent and ((question.parent.type == :radio     and value[question.parent.key] != question.parent_option_key.to_s) or
                               (question.parent.type == :check_box and value[question.parent.key][question.parent_option_key] == 0))) or
         @hidden_questions.andand.include?(question.key)
        clear_question(question)
        next
      end

      unless question.depends_on.blank?
        should_validate = false
        question.depends_on.each do |key|
          should_validate = should_validate || self.send(key)
        end
        next unless should_validate
      end

      answer = self.send(question.key)
      validations = question.validations

      if not validations.empty?
        #logger.info "Validating #{question.key} = #{question.validations.inspect}."

        question.validations.each do |validation|
          case validation[:type]
          when :valid_integer
            next if answer.blank?
            begin
              Integer(answer)
            rescue ArgumentError
              add_error(question, :valid_integer, validation[:message] || "Invalid integer")
            end
          when :valid_float
            next if answer.blank?
            begin
              Float(answer)
            rescue ArgumentError
              add_error(question, :valid_float, validation[:message] || "Invalid float")
            end
          when :regexp
            next if answer.blank?
            match = validation[:matcher].match(answer)
            add_error(question, validation[:type], validation[:message] || "Does not match pattern expected.") if not match or match[0] != answer
          when :requires_answer
            next if @hidden_questions.include?(question.key)
            if question.type == :check_box
              add_error(question, validation[:type], validation[:message] || "Must be answered.") if answer.values.reduce(:+) == 0
            else
              add_error(question, validation[:type], validation[:message] || "Must be answered.") if answer.blank?
            end
          when :minimum
            add_error(question, validation[:type], validation[:message] || "Smaller than minimum") if not answer.blank? and answer.to_f < validation[:value]
          when :maximum
            add_error(question, validation[:type], validation[:message] || "Exceeds maximum") if not answer.blank? and answer.to_f > validation[:value]
          when :too_many_checked
            if self.send(question.uncheck_all_option) == 1 and answer.values.reduce(:+) > 1
              add_error(question, :too_many_checked, validation[:message] || "Invalid combination of options.")
            end
          when :not_all_checked
            if self.send(question.check_all_option) == 1 and answer.values.reduce(:+) < answer.length - (question.uncheck_all_option ? 1 : 0)
              add_error(question, :not_all_checked, validation[:message] || "Invalid combination of options.")
            end
          when :one_of
            add_error(question, :one_of, validation[:message] || "Not one of the options.") if not answer.blank? and not validation[:array].include?(answer.to_f)
          when :answer_group_minimum
            answered = calc_answered(@question_groups[validation[:group]])
            if answered < validation[:value]
              add_error(question, :answer_group_minimum, validation[:message] || "Needs at least #{validation[:value]} question(s) answered.")
            end
          when :answer_group_maximum
            answered = calc_answered(@question_groups[validation[:group]])
            if answered > validation[:value]
              add_error(question, :answer_group_maximum, validation[:message] || "Needs at most #{validation[:value]} question(s) answered.")
            end
          end
        end        
      end      
    end
    #logger.info "ERRORS: #{errors.inspect}"
  end

  protected

  def calc_answered(qkeys)
    answered = 0
    qkeys.each do |qk|
      ans = self.send(qk)
      if ans.class == Hash # in case of check_box, only count checked check_boxes as answered
        answered += ans.values.sum >= 1 ? 1 : 0
      elsif not self.send(qk).blank?
        answered += 1
      end
    end
    return answered
  end

  def add_error(question, validationtype, message)
    errors.add(question.key, {:message => message, :valtype => validationtype})
  end

  def generate_random_token
    self.token ||= SecureRandom.hex(8)
  end

end
