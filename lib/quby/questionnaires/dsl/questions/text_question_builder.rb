module Quby
  module Questionnaires
    module DSL
      module Questions
        class TextQuestionBuilder < Base
          def validates_format_with(regexp, options = {})
            @question.validations ||= []
            @question.validations << {type: :regexp, matcher: regexp}.reverse_merge(options)
          end
        end
      end
    end
  end
end
