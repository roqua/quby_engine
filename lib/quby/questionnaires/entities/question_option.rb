module Quby
  module Questionnaires
    module Entities
      class QuestionOption
        attr_accessor :key
        attr_accessor :value
        attr_accessor :description
        attr_accessor :questions
        attr_accessor :inner_title
        attr_accessor :hides_questions
        attr_accessor :shows_questions
        attr_accessor :hidden
        attr_accessor :placeholder
        attr_accessor :question
        attr_accessor :view_id

        attr_accessor :start_chosen

        def initialize(key, question, options = {})
          @key         = key
          @question    = question
          @value       = options[:value]
          @description = options[:description]
          @questions   = []
          @inner_title = options[:inner_title]
          @hides_questions = options[:hides_questions] || []
          @shows_questions = options[:shows_questions] || []
          @hidden = options[:hidden] || false
          @view_id = "answer_#{input_key}"
          @placeholder = options[:placeholder] || false
          question.extra_data[:placeholder] = key if @placeholder
        end

        def input_key
          question.type == :check_box ? @key : "#{question.key}_#{key}".to_sym
        end

        def inner_title?
          inner_title.present?
        end

        def key_in_use?(k)
          return true if k == input_key
          @questions.each { |q| return true if q.key_in_use?(k) }
          false
        end

        def as_json(options = {})
          {
            key: key,
            value: value,
            description: description,
            questions: questions,
            inner_title: inner_title,
            hides_questions: hides_questions,
            shows_questions: shows_questions,
            hidden: hidden,
            placeholder: placeholder,
            view_id: view_id
          }
        end

        def to_codebook(questionnaire, opts)
          return nil if inner_title
          output = []

          if question.type == :check_box
            option_key = question.codebook_key(key, questionnaire, opts)
            output << "#{option_key} #{question.codebook_output_type}#{' deprecated' if hidden}"
            output << "\"#{question.title} -- #{description}\"" unless question.title.blank? and description.blank?
            output << "1\tChecked"
            output << "0\tUnchecked"
            output << "empty\tUnchecked"
          else
            output << "#{value || key}\t\"#{description}\"#{' deprecated' if hidden}"
          end

          questions.each do |subquestion|
            output << "\t#{subquestion.to_codebook(questionnaire, opts).gsub("\n", "\n\t")}"
          end

          output.join("\n")
        end
      end
    end
  end
end
