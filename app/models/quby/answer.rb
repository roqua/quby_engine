module Quby
  class Answer
    def self.questionnaire_finder
      Quby.questionnaire_finder
    end

    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    include OutcomeCalculations

    store_in :answers

    identity type: String
    field :questionnaire_id,     type: Integer
    field :questionnaire_key,    type: String
    field :value,                type: Hash
    field :value_by_values,      type: Hash
    field :patient,              type: Hash,    default: {}
    field :token,                type: String
    field :active,               type: Boolean, default: true
    field :test,                 type: Boolean, default: false
    field :completed_at,         type: Time
    field :outcome_generated_at, type: Time
    field :scores,               type: Hash,    default: {}
    field :actions,              type: Hash,    default: {}
    field :completion,           type: Hash,    default: {}
    field :activity_log,         type: String,  default: ""

    # Faux belongs_to :questionnaire
    def questionnaire
      self.class.questionnaire_finder.find(questionnaire_key)
    end

    after_initialize :enhance_by_dsl
    before_validation(on: :create) { set_default_answer_values }
    before_validation(on: :create) { generate_random_token }

    before_save do
      self[:questionnaire_key] = questionnaire.key
      self[:value_by_values] = value_by_values
    end

    before_update do
      self[:completed_at] ||= Time.now if completed? or @aborted
    end

    validates_presence_of :token
    validates_length_of :token, minimum: 4

    attr_accessor :aborted
    # Values in globalpark coding that need to be recoded and used to initialize this answer
    attr_accessor :roqua_vals

    # For setting raw content values and failed validations
    attr_accessor :extra_question_values
    attr_accessor :extra_failed_validations

    attr_accessor :dsl_last_update

    def enhance_by_dsl
      AnswerDsl.enhance(self)
    end

    def patient_id
      self[:patient][:id] || self[:patient_id]
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

    def value_by_values
      result = {}
      if value
        result = value.dup
        value.each_key do |key|
          question = questionnaire.questions.find { |q| q.andand.key.to_s == key.to_s }
          if question and (question.type == :radio || question.type == :scale || question.type == :select)
            option = question.options.find { |o| o.key.to_s == value[key].to_s }
            if option
              result[key] = option.value.to_s
            end
          end
        end
      end
      result
    rescue Exception => e
      logger.error "RESCUED #{e.message} \n #{e.backtrace.join('\n')}"
      {}
    end

    def value_by_regular_values
      result = {}
      if value
        result = value.dup
        value.each do |key, answer|
          question = questionnaire.questions.find { |q| q.andand.key.to_s == key.to_s }
          if question
            if question.type == :radio || question.type == :scale || question.type == :select
              option = question.options.find { |o| o.key.to_s == value[key].to_s }
              if option
                result[key] = option.value
              end
            elsif question.type == :integer
              result[key] = answer.to_i if answer
            elsif question.type == :float
              result[key] = answer.to_f if answer
            end
          end
        end
      end
      result
    rescue Exception => e
      logger.error "RESCUED #{e.message} \n #{e.backtrace.join('\n')}"
      {}
    end

    def scores
      read_attribute(:scores).with_indifferent_access
    end

    def actions
      read_attribute(:actions).with_indifferent_access
    end

    def as_json(options = {})
      attributes.merge(
        id: self.id,
        value_by_values: value_by_values,
        scores: self.scores,
        is_completed: self.completed? ? true : false
      )
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

    def url_params(options = {})
      if request = options[:request]
        server_path = "#{request.protocol}#{request.host}#{":" + request.port.to_s unless [80, 443].include? request.port}/"
        options.delete(:request)
      end

      timestamp = Time.now.getgm.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      plain_token = [Quby::Settings.shared_secret, self.token, timestamp].join('|')

      # double slash removed from return_url (it's either this or removing the final slash in Settings.application_url)
      options = options.merge(
        display_mode: options[:display_mode] || "paged",
        token: self.token,
        timestamp: timestamp,
        hmac: Digest::SHA1.hexdigest(plain_token)
      )
    end

    protected

    def calc_answered(qkeys)
      answered = 0
      qkeys.each do |qk|
        ans = self.send(qk)
        if ans.is_a? Hash # in case of check_box, only count checked check_boxes as answered
          answered += (ans.values.sum >= 1 ? 1 : 0)
        elsif not self.send(qk).blank?
          answered += 1
        end
      end
      answered
    end

    def add_error(question, validationtype, message)
      errors.add(question.key, {message: message, valtype: validationtype})
    end

    def generate_random_token
      self.token ||= SecureRandom.hex(8)
    end

    def set_default_answer_values
      self.value = (questionnaire.default_answer_value || {}).merge(self.value || {})
    end
  end
end
