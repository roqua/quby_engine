# frozen_string_literal: true

require 'active_model'
require 'quby/answers/entities/outcome'
require 'quby/answers/dsl'

module Quby
  module Answers
    module Entities
      class Answer
        extend ActiveModel::Naming
        extend ActiveModel::Translation

        # @return [String]
        attr_accessor :_id

        # @return [String]
        attr_accessor :questionnaire_id

        # @return [String]
        attr_accessor :questionnaire_key

        # The raw form data (for recovery purposes)
        # @return [Hash]
        attr_accessor :raw_params

        # The filtered and transformed form data
        # @return [Hash]
        attr_accessor :value

        # @return [String]
        attr_accessor :patient_id

        # @return [Hash]
        attr_accessor :patient

        # @return [String]
        attr_accessor :token

        # @return [Boolean]
        attr_accessor :active

        # @return [Boolean]
        attr_accessor :test

        # @return [Time]
        attr_accessor :created_at

        # @return [Time]
        attr_accessor :updated_at

        # @return [Time]
        attr_accessor :started_at

        # The observation time of the response, the date at which the information in the response was collected
        # This is used to calculate the age of the respondent at the time of filling out for example
        # @return [Time]
        attr_accessor :completed_at

        # The time at which the response was entered into the system,
        # not necessarily the same as the observation time, which is stored in completed_at
        # @return [Time]
        attr_accessor :entered_at

        # @return [Outcome]
        attr_accessor :outcome

        # @return [Time]
        attr_accessor :dsl_last_update

        # For answers that are imported from external sources
        # @return [Hash]
        attr_accessor :import_notes

        # @return [Hash<String, Boolean>]
        attr_accessor :flags

        # @return [Hash<String, String>]
        attr_accessor :textvars

        attr_accessor :outcome_generated_at
        attr_writer :scores
        attr_writer :actions
        attr_writer :completion

        attr_accessor :aborted

        # For setting raw content values and failed validations
        attr_accessor :extra_question_values
        attr_accessor :extra_failed_validations

        def initialize(_id: nil, questionnaire_id: nil, questionnaire_key: nil,
          raw_params: nil, value: nil, patient_id: nil, patient: nil,
          token: nil, active: true, test: false, created_at: nil, updated_at: nil,
          started_at: nil, completed_at: nil, outcome: nil, outcome_generated_at: nil,
          scores: nil, actions: nil, completion: nil, dsl_last_update: nil, import_notes: nil,
          flags: nil, textvars: nil, entered_at: nil)

          self._id = _id
          self.questionnaire_id = questionnaire_id
          self.questionnaire_key = questionnaire_key
          self.raw_params = raw_params || {}
          self.value = value || {}
          self.patient_id = patient_id
          self.patient = patient || {}
          self.token = token
          self.active = active
          self.test = test
          self.created_at = created_at
          self.updated_at = updated_at
          self.started_at = started_at
          self.completed_at = completed_at
          self.entered_at = entered_at
          self.outcome_generated_at = outcome_generated_at
          self.scores = scores || {}
          self.actions = actions || {}
          self.completion = completion || {}
          self.dsl_last_update = dsl_last_update
          self.import_notes = import_notes || {}
          self.flags = flags
          self.textvars = textvars
        end

        def id
          _id
        end

        def _id=(value)
          @_id = value.to_s
        end

        def to_param
          id
        end

        def attributes
          HashWithIndifferentAccess.new({
            _id: _id,
            questionnaire_id: questionnaire_id,
            questionnaire_key: questionnaire_key,
            raw_params: raw_params,
            value: value,
            patient_id: patient_id,
            patient: patient,
            token: token,
            active: active,
            test: test,
            created_at: created_at,
            updated_at: updated_at,
            started_at: started_at,
            completed_at: completed_at,
            entered_at: entered_at,
            outcome_generated_at: outcome_generated_at,
            scores: scores,
            actions: actions,
            completion: completion,
            dsl_last_update: dsl_last_update,
            import_notes: import_notes,
            flags: flags,
            textvars: textvars
          })
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

        def mark_completed(start_time:)
          if completed? || @aborted
            self.started_at = start_time if started_at.blank?
            self.completed_at = Time.now if completed_at.blank?
            self.entered_at = Time.now if entered_at.blank?
          end
        end

        def enhance_by_dsl
          DSL.enhance(self)
        end

        def patient_id
          patient[:id] || @patient_id
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
              question = questionnaire.questions.find { |q| q&.key.to_s == key.to_s }
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
          if defined? Roqua::Support::Errors
            Roqua::Support::Errors.report e, root_path: Rails.root.to_s
          end
          raise e if Rails.env.development? || Rails.env.test?
          Rails.logger.error "RESCUED #{e.message} \n #{e.backtrace.join('\n')}"
          {}
        end

        def value_by_regular_values
          result = {}
          if value
            result = value.dup
            value.each do |key, answer|
              question = questionnaire.questions.find { |q| q&.key.to_s == key.to_s }
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
          if defined? Roqua::Support::Errors
            Roqua::Support::Errors.report e, root_path: Rails.root.to_s
          end
          raise e if Rails.env.development? || Rails.env.test?
          Rails.logger.error "RESCUED #{e.message} \n #{e.backtrace.join('\n')}"
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

        def completion
          outcome.completion
        end

        def action
          outcome.action
        end

        def flags=(value)
          return unless value
          @flags = value.symbolize_keys
        end

        def textvars=(value)
          return unless value
          @textvars = value.symbolize_keys
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
