require 'virtus'

module Quby
  class Answer
    def self.questionnaire_finder
      Quby.questionnaire_finder
    end

    extend ActiveModel::Naming
    include Virtus
    include OutcomeCalculations

    attribute :_id, String
    attribute :questionnaire_id,     Integer
    attribute :questionnaire_key,    String
    attribute :value,                Hash
    attribute :patient_id,           String
    attribute :patient,              Hash,    default: {}
    attribute :token,                String
    attribute :active,               Boolean, default: true
    attribute :test,                 Boolean, default: false
    attribute :completed_at,         Time
    attribute :outcome_generated_at, Time
    attribute :scores,               Hash,    default: {}
    attribute :actions,              Hash,    default: {}
    attribute :completion,           Hash,    default: {}

    def id
      _id
    end

    def to_param
      id
    end

    def reload
      Rails.logger.info "reloading #{id}"
      Quby.answer_repo.find(questionnaire_key, id)
    end

    def attributes
      super.with_indifferent_access
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end

    def valid?
      errors.empty?
    end

    # Faux belongs_to :questionnaire
    def questionnaire
      self.class.questionnaire_finder.find(questionnaire_key)
    end

    attr_accessor :aborted
    # Values in globalpark coding that need to be recoded and used to initialize this answer
    attr_accessor :roqua_vals

    # For setting raw content values and failed validations
    attr_accessor :extra_question_values
    attr_accessor :extra_failed_validations

    attr_accessor :dsl_last_update

    def set_completed_at
      self.completed_at = Time.now if completed_at.blank? and (completed? or @aborted)
    end

    def enhance_by_dsl
      AnswerDsl.enhance(self)
    end

    def patient_id
      self.patient[:id] || super
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
          next unless question
          if question.type == :radio || question.type == :scale || question.type == :select
            option = question.options.find { |o| o.key.to_s == value[key].to_s }
            result[key] = option.value if option
          elsif question.type == :integer
            result[key] = answer.to_i if answer
          elsif question.type == :float
            result[key] = answer.to_f if answer
          end
        end
      end
      result
    rescue Exception => e
      logger.error "RESCUED #{e.message} \n #{e.backtrace.join('\n')}"
      {}
    end

    def scores
      (@scores || {}).with_indifferent_access
    end

    def actions
      (@actions || {}).with_indifferent_access
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
      not all_blank? and valid?
    end

    def all_blank?
      questionnaire.questions.reduce(true) do |all_blank, question|
        next all_blank unless question
        all_blank and self.send(question.key).blank?
      end
    end

    def url_params(options = {})
      timestamp = Time.now.getgm.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      plain_token = [Quby::Settings.shared_secret, self.token, timestamp].join('|')

      # double slash removed from return_url (it's either this or removing the final slash in Settings.application_url)
      options.merge(
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

  end
end
