# frozen_string_literal: true

module Quby
  module Questionnaires
    module Entities
      module Questions
        class DateQuestion < Question
          POSSIBLE_COMPONENTS = %i( day month year hour minute )
          COMPONENT_KEYS = Hash[POSSIBLE_COMPONENTS.zip %w( dd mm yyyy hh ii)]
          COMPONENT_PLACEHOLDERS = Hash[POSSIBLE_COMPONENTS.zip %w( DD MM YYYY hh mm)]
          DEFAULT_COMPONENTS = %i( day month year )

          # For optionally giving year, month and day fields of dates their own keys
          POSSIBLE_COMPONENTS.each do |component|
            attr_accessor "#{component}_key".to_sym
          end

          # @!attribute [r] components
          #   @return [Array<Symbol>] date parts to show
          # @!attribute [r] required_components
          #   @return [Array<Symbol>] date parts that are required if the question is required or partly filled out.
          attr_accessor :components, :required_components, :optional_components

          def initialize(key, options = {})
            super

            @components = options[:components] || DEFAULT_COMPONENTS
            @required_components = options[:required_components] || @components
            @optional_components = @components - @required_components

            components.each do |component|
              component_key = options[:"#{component}_key"] || "#{key}_#{COMPONENT_KEYS[component]}"
              instance_variable_set("@#{component}_key", component_key.to_sym)
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

          def variable_descriptions
            components.each_with_object(key => context_free_title) do |component, hash|
              key = send("#{component}_key")
              hash[key] = "#{context_free_title} (#{I18n.t component})"
            end.with_indifferent_access
          end

          def as_json(options = {})
            component_keys = components.each_with_object({}) do |component, hash|
              hash["#{component}Key"] = send("#{component}_key")
            end
            super.merge(components: components).merge(component_keys)
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
