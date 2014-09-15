module Quby
  module Questionnaires
    module Entities
      class Flag < Struct.new(:key, :description, :shows_questions, :hides_questions)
        def initialize(key:, description:, shows_questions: [], hides_questions: [])
          super(key, description, shows_questions, hides_questions)
        end
      end
    end
  end
end
