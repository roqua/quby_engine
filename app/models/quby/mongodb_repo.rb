module Quby
  class MongodbRepo
    class Record
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

      # Faux belongs_to :questionnaire
      def questionnaire
        Quby.questionnaire_finder.find(questionnaire_key)
      end

      before_validation(on: :create) { set_default_answer_values }
      before_validation(on: :create) { generate_random_token }

      before_save do
        self[:questionnaire_key] = questionnaire.key
        self[:value_by_values] = value_by_values
      end

      validates_presence_of :token
      validates_length_of :token, minimum: 4

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

      def generate_random_token
        self.token ||= SecureRandom.hex(8)
      end

      def set_default_answer_values
        self.value = (questionnaire.default_answer_value || {}).merge(self.value || {})
      end

    end

    attr_reader :mongo_collection

    def initialize(mongo_collection)
      @mongo_collection = mongo_collection
    end

    def find(questionnaire_key, answer_id)
      record = Record.where(questionnaire_key: questionnaire_key).find(answer_id)

      entity = Quby::Answer.new(record.attributes)
      entity.instance_variable_set(:@new_record, nil)
      entity.instance_variable_set(:@changed_attributes, nil)
      entity.instance_variable_set(:@pending_nested, nil)
      entity.instance_variable_set(:@pending_relations, nil)
      entity.enhance_by_dsl
      entity
    end

    def create!(questionnaire_key, attributes = {})
      record = Record.create!(attributes.merge(questionnaire_key: questionnaire_key))
      find(questionnaire_key, record.id)
    end

    def create(questionnaire_key, attributes = {})
      create!(questionnaire_key, attributes)
    end

    def update!(answer)
      record = Record.find(answer.id)
      record.value                = answer.value
      record.value_by_values      = answer.value_by_values
      record.patient              = answer.patient
      record.token                = answer.token
      record.active               = answer.active
      record.test                 = answer.test
      record.completed_at         = answer.completed_at
      record.outcome_generated_at = answer.outcome_generated_at
      record.scores               = answer.scores
      record.actions              = answer.actions
      record.completion           = answer.completion

      Rails.logger.info "Saving #{answer.id} -- #{answer.inspect}"
      record.save!
    end

    def update(answer)
      update!(answer)
    end
  end
end