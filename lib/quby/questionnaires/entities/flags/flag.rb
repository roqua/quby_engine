module Quby
  module Questionnaires
    module Entities
      class Flag < Struct.new(:key, :description_true, :description_false, :shows_questions, :hides_questions)
        def initialize(key:, description_true:, description_false:, shows_questions: [], hides_questions: [])
          super(key, description_true, description_false, shows_questions, hides_questions)
        end
      end
    end
  end
end
