# frozen_string_literal: true

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
            @question = Entities::Questions::RadioQuestion.new(key, options)
          end
        end
      end
    end
  end
end
