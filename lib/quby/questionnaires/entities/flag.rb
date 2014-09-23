module Quby
  module Questionnaires
    module Entities
      class Flag < Struct.new(:key, :description_true, :description_false, :internal,
                              :shows_questions, :hides_questions)
        # rubocop:disable ParameterLists
        def initialize(key:,
                       description_true:,
                       description_false:,
                       internal: false,
                       shows_questions: [],
                       hides_questions: [])
          super(key, description_true, description_false, internal, shows_questions, hides_questions)
        end
        # rubocop:enable ParameterLists
      end
    end
  end
end
