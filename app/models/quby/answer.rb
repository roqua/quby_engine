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
    attribute :dsl_last_update

    attr_accessor :aborted

    # For setting raw content values and failed validations
    attr_accessor :extra_question_values
    attr_accessor :extra_failed_validations

    def id
      _id
    end

    def to_param
      id
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

    def set_completed_at
      self.completed_at = Time.now if completed_at.blank? && (completed? || @aborted)
    end

    def enhance_by_dsl
      AnswerDsl.enhance(self)
    end

    def patient_id
      patient[:id] || super
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
          @extra_failed_validations[q.key] = errors[q.key] if errors[q.key].present?
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
      super.with_indifferent_access
    end

    def actions
      super.with_indifferent_access
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
      !all_blank? && valid?
    end

    def all_blank?
      questionnaire.questions.reduce(true) do |all_blank, question|
        next all_blank unless question
        all_blank and self.send(question.key).blank?
      end
    end

    def url_params(options = {})
      Quby::AnswersHelper.url_params(token, options)
    end

    protected

    def calc_answered(qkeys)
      answered = 0
      qkeys.each do |qk|
        ans = self.send(qk)
        if ans.is_a? Hash # in case of check_box, only count checked check_boxes as answered
          answered += (ans.values.sum >= 1 ? 1 : 0)
        elsif self.send(qk).present?
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
