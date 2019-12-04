# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      class QuestionOption
        MARKDOWN_ATTRIBUTES = %w(description).freeze

        attr_reader :key
        attr_reader :value
        attr_reader :description
        attr_reader :questions
        attr_reader :inner_title
        attr_reader :hides_questions
        attr_reader :shows_questions
        attr_reader :hidden
        attr_reader :placeholder
        attr_reader :question
        attr_reader :view_id
        attr_reader :input_key

        attr_reader :start_chosen

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
          @placeholder = options[:placeholder] || false
          question.extra_data[:placeholder] = key if @placeholder

          @input_key = (question.type == :check_box ? @key : "#{question.key}_#{key}".to_sym)
          @view_id   = "answer_#{input_key}"
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
            description: Quby::MarkdownParser.new(description).to_html,
            questions: questions,
            innerTitle: inner_title,
            hidesQuestions: hides_questions,
            showsQuestions: shows_questions,
            hidden: hidden,
            placeholder: placeholder,
            viewId: view_id
          }
        end

        def to_codebook(questionnaire, opts)
          return nil if inner_title
          output = []

          if question.type == :check_box
            option_key = question.codebook_key(key, questionnaire, opts)
            output << "#{option_key} #{question.codebook_output_type}#{' deprecated' if hidden || question.hidden }"
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
