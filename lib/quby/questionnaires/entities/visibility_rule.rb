module Quby
  module Questionnaires
    module Entities
      class VisibilityRule
        def self.from(question)
          rules = []

          # Transform "default invisible" into just being hidden by itself,
          # since any other question showing it will take precedence anyway.
          if question.default_invisible
            rules << new(condition: { type: :always, field_key: question.key },
                         action: { type: :hide_question, field_key: question.key })
          end

          case question.type
          when :radio, :scale, :select
            question.options.each do |option|
              option.shows_questions.each do |shows_question|
                rules << new(condition: { type: :equal, field_key: question.key, value: option.key },
                             action: { type: :show_question, field_key: shows_question })
              end + option.hides_questions.map do |hides_question|
                rules << new(condition: { type: :equal, field_key: question.key, value: option.key },
                             action: { type: :hide_question, field_key: hides_question })
              end
            end
          when :checkbox
            question.options.each do |option|
              option.shows_questions.each do |shows_question|
                rules << new(condition: { type: :includes, field_key: question.key, value: option.key },
                             action: { type: :show_question, field_key: shows_question })
              end + option.hides_questions.each do |hides_question|
                rules << new(condition: { type: :includes, field_key: question.key, value: option.key },
                             action: { type: :hide_question, field_key: hides_question })
              end
            end
          end

          rules
        end

        attr_reader :condition, :action

        def initialize(condition:, action:)
          @condition = condition
          @action = action
        end

        def as_json
          {
            condition: condition,
            action: action,
          }
        end
      end
    end
  end
end
