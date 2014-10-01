module Quby
  module Questionnaires
    module Entities
      class Flag < Struct.new(:key, :description_true, :description_false, :internal, :trigger_on,
                              :shows_questions, :hides_questions)
        # rubocop:disable ParameterLists
        def initialize(key:,
                       description_true:,
                       description_false:,
                       internal: false,
                       trigger_on: true,
                       shows_questions: [],
                       hides_questions: [])
          super(key, description_true, description_false, internal, trigger_on, shows_questions, hides_questions)
        end
        # rubocop:enable ParameterLists
      end
    end
  end
end
