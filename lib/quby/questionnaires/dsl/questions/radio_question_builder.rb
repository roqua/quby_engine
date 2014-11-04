module Quby
  module Questionnaires
    module DSL
      module Questions
        class RadioQuestionBuilder < Base
          include MultipleChoice
          include Subquestions
          include InnerTitles

          def initialize(key, options = {}, &block)
            super
            @default_question_options = options[:default_question_options] || {}
            @title_question = nil
            @question = Entities::Questions::RadioQuestion.new(key, options)
          end
        end
      end
    end
  end
end
