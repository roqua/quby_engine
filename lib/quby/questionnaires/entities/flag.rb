module Quby
  module Questionnaires
    module Entities
      class Flag < Struct.new(:key, :description_true, :description_false, :description, :internal, :trigger_on,
                              :shows_questions, :hides_questions, :depends_on, :default_in_interface)
        # rubocop:disable ParameterLists
        def initialize(key:,
                       description_true:,
                       description_false:,
                       description: nil,
                       internal: false,
                       trigger_on: true,
                       shows_questions: [],
                       hides_questions: [],
                       depends_on: nil, # used in interface to hide this flag unless the depended on flag is set to true
                       default_in_interface: nil) # used in interface to set a default for the flag state,
                                                  # does not have an effect outside of the interface
          super(key, description_true, description_false, description, internal, trigger_on, shows_questions,
                hides_questions, depends_on, default_in_interface)
        end
        # rubocop:enable ParameterLists

        def if_triggered_by(answer_flags)
          yield if answer_flags[key] == trigger_on
        end

        def to_codebook(_options = {})
          output = []
          output << "#{key} flag"
          output << "'#{description}'" if description.present?
          output << " 'true' - #{description_true}"
          output << " 'false' - #{description_false}"
          output << " '' (leeg) - Vlag niet ingesteld, informatie onbekend"
          output << ""
          output.join("\n")
        end
      end
    end
  end
end
