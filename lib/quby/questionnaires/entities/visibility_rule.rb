module Quby
  module Questionnaires
    module Entities
      class VisibilityRule
        def self.from(question)
          [].tap do |rules|
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
                end

                option.hides_questions.each do |hides_question|
                  rules << new(condition: { type: :equal, field_key: question.key, value: option.key },
                               action: { type: :hide_question, field_key: hides_question })
                end
              end
            when :check_box
              question.options.each do |option|
                option.shows_questions.each do |shows_question|
                  rules << new(condition: { type: :contains, field_key: question.key, value: option.key },
                               action: { type: :show_question, field_key: shows_question })
                end

                option.hides_questions.each do |hides_question|
                  rules << new(condition: { type: :contains, field_key: question.key, value: option.key },
                               action: { type: :hide_question, field_key: hides_question })
                end
              end
            end
          end
        end

        def self.from_flag(flag)
          condition = { type: "flag_equal", flagKey: flag.key, value: flag.trigger_on }

          [].tap do |rules|
            flag.shows_questions.map do |question_key|
              rules << VisibilityRule.new(condition: condition, action: { type: "show_question", field_key: question_key })
            end

            flag.hides_questions.map do |question_key|
              rules << VisibilityRule.new(condition: condition, action: { type: "hide_question", field_key: question_key })
            end
          end
        end

        attr_reader :condition, :action

        def initialize(condition:, action:)
          @condition = condition
          @action = action
        end

        def as_json
          {
            condition: condition.transform_keys { |key| key.to_s.camelize(:lower) },
            action: action.transform_keys { |key| key.to_s.camelize(:lower) },
          }
        end
      end
    end
  end
end
