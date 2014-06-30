require 'virtus'
require 'active_model'
require 'quby/answers/entities/outcome'
require 'quby/answers/dsl'

module Quby
  module Answers
    module Entities
      class Answer
        extend ActiveModel::Naming
        include Virtus.model

        attribute :_id, String
        attribute :questionnaire_id,     Integer
        attribute :questionnaire_key,    String
        attribute :raw_params,           Hash                      # The raw form data (for recovery purposes)
        attribute :value,                Hash                      # The filtered and transformed form data
        attribute :patient_id,           String
        attribute :patient,              Hash,    default: {}
        attribute :token,                String
        attribute :active,               Boolean, default: true
        attribute :test,                 Boolean, default: false
        attribute :created_at,           Time
        attribute :updated_at,           Time
        attribute :completed_at,         Time
        attribute :outcome,              Outcome
        attribute :outcome_generated_at, Time
        attribute :scores,               Hash,    default: {}
        attribute :actions,              Hash,    default: {}
        attribute :completion,           Hash,    default: {}
        attribute :dsl_last_update
        attribute :import_notes,         Hash                      # For answers that are imported from external sources

        attr_accessor :aborted

        # For setting raw content values and failed validations
        attr_accessor :extra_question_values
        attr_accessor :extra_failed_validations

        def initialize(attributes = {})
          super

          # Initialize Hash attributes to empty hash even when explicitly given nil.
          # This differs from Virtus' default behaviour which would set them to nil.
          self.class.attribute_set.each do |attribute|
            if attribute.type.is_a? Virtus::Attribute::Hash::Type
              public_send(:"#{attribute.name}=", public_send(attribute.name) || {})
            end
          end
        end

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
          Quby.questionnaires.find(questionnaire_key)
        end

        def set_completed_at
          self.completed_at = Time.now if completed_at.blank? && (completed? || @aborted)
        end

        def enhance_by_dsl
          DSL.enhance(self)
        end

        def patient_id
          patient[:id] || super
        end

        def extra_question_values
          @extra_question_values = {}
          questionnaire.questions.each do |q|
            next unless q
            unless q.raw_content.blank?
              @extra_question_values[q.key] = send(q.key)
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

        def outcome
          Outcome.new(scores: @scores, actions: @actions, completion: @completion, generated_at: @outcome_generated_at)
        end

        def outcome=(outcome)
          self.scores               = outcome.scores
          self.actions              = outcome.actions
          self.completion           = outcome.completion
          self.outcome_generated_at = outcome.generated_at
        end

        def scores
          outcome.scores
        end

        def actions
          outcome.actions
        end

        def action
          outcome.action
        end

        def as_json(options = {})
          attributes.merge(
              id: id,
              value_by_values: value_by_values,
              scores: scores,
              is_completed: self.completed? ? true : false
          )
        end

        def completed?
          !all_blank? && valid?
        end

        def all_blank?
          questionnaire.questions.reduce(true) do |all_blank, question|
            next all_blank unless question
            all_blank and send(question.key).blank?
          end
        end

        def url_params(options = {})
          timestamp = Time.now.getgm.strftime("%Y-%m-%dT%H:%M:%S+00:00")
          plain_token = [Quby::Settings.shared_secret, token, timestamp].join('|')

          # double slash removed from return_url (it's either this or removing the
          # final slash in Settings.application_url)
          options.merge(
              display_mode: options[:display_mode] || "paged",
              token: token,
              timestamp: timestamp,
              hmac: Digest::SHA1.hexdigest(plain_token)
          )
        end

        protected

        def calc_answered(qkeys)
          answered = 0
          qkeys.each do |qk|
            ans = send(qk)
            if ans.is_a? Hash # in case of check_box, only count checked check_boxes as answered
              answered += (ans.values.sum >= 1 ? 1 : 0)
            elsif send(qk).present?
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
  end
end
