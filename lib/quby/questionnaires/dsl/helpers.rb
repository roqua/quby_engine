# frozen_string_literal: true

module Quby
  module Questionnaires
    module DSL
      module Helpers
        def image_tag(*args)
          ActionController::Base.helpers.image_tag(*args)
        end

        def check_question_keys_uniqueness(key, options, questionnaire)
          keys = QuestionBuilder.build(key, options).claimed_keys
          if keys.any? { |k| questionnaire.key_in_use? k }
            fail "#{questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
          end
        end
      end
    end
  end
end
