# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Questions
        class DateQuestion < Question
          POSSIBLE_COMPONENTS = %i( day month year hour minute )
          COMPONENT_KEYS = Hash[POSSIBLE_COMPONENTS.zip %w( dd mm yyyy hh ii)]
          COMPONENT_PLACEHOLDERS = Hash[POSSIBLE_COMPONENTS.zip %w( DD MM YYYY hh mm)]
          DEFAULT_COMPONENTS  = %i( day month year )

          # For optionally giving year, month and day fields of dates their own keys
          POSSIBLE_COMPONENTS.each do |component|
            attr_accessor "#{component}_key".to_sym
          end

          attr_accessor :components

          def initialize(key, options = {})
            super

            @components = options[:components] || DEFAULT_COMPONENTS

            components.each do |component|
              instance_variable_set("@#{component}_key", options[:"#{component}_key"])
            end

            add_date_validation(options[:error_explanation])
          end

          def add_date_validation(explanation)
            @validations << {type: :valid_date,
                             subtype: :"valid_date_#{components.sort.join('_')}",
                             explanation: explanation}
          end

          COMPONENT_KEYS.each do |component, name|
            define_method("#{component}_key") do
              (instance_variable_get("@#{component}_key") || "#{key}_#{name}").to_s
            end
          end

          def claimed_keys
            [key] + answer_keys
          end

          def answer_keys
            components.map do |component|
              send("#{component}_key").to_sym
            end
          end

          def as_json(options = {})
            component_keys = components.each_with_object({}) do |component, hash|
              hash["#{component}_key"] = send("#{component}_key")
            end
            super.merge(component_keys)
          end

          def to_codebook(questionnaire, opts = {})
            output = []
            components.each do |component|
              output << "#{codebook_key(send("#{component}_key"), questionnaire, opts)} " \
              "#{type}_#{component} #{codebook_output_range}"
              output << "\"#{title}\"" unless title.blank?
              output << options.map(&:to_codebook).join("\n") unless options.blank?
              output << ""
            end
            output.join("\n")
          end
        end
      end
    end
  end
end
