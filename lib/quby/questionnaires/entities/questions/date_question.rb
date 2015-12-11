module Quby
  module Questionnaires
    module Entities
      module Questions
        class DateQuestion < Question
          POSSIBLE_COMPONENTS = %i( year month day hour minute )
          COMPONENT_KEYS = Hash[POSSIBLE_COMPONENTS.zip %w( yyyy mm dd hh ii)]
          DEFAULT_COMPONENTS  = %i( year month day )

          # For optionally giving year, month and day fields of dates their own keys
          POSSIBLE_COMPONENTS.each do |component|
            attr_accessor "#{component}_key".to_sym
          end

          attr_accessor :components

          def initialize(key, options = {})
            super

            @components = options[:components] || DEFAULT_COMPONENTS

            @components.each do |component|
              instance_variable_set("@#{component}_key", options[:"#{component}_key"])
            end
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
            @components.map do |component|
              send("#{component}_key").to_sym
            end
          end

          def as_json(options = {})
            component_keys = @components.each_with_object({}) do |component, hash|
              hash["#{component}_key"] = send("#{component}_key")
            end
            super.merge(component_keys)
          end

          def to_codebook(questionnaire, opts = {})
            output = []
            output << "#{codebook_key(day_key, questionnaire, opts)} #{type}_day #{codebook_output_range}"
            output << "\"#{title}\"" unless title.blank?
            output << options.map(&:to_codebook).join("\n") unless options.blank?
            output << ""
            output << "#{codebook_key(month_key, questionnaire, opts)} #{type}_month #{codebook_output_range}"
            output << "\"#{title}\"" unless title.blank?
            output << options.map(&:to_codebook).join("\n") unless options.blank?
            output << ""
            output << "#{codebook_key(year_key, questionnaire, opts)} #{type}_year #{codebook_output_range}"
            output << "\"#{title}\"" unless title.blank?
            output << options.map(&:to_codebook).join("\n") unless options.blank?
            output << ""
            output.join("\n")
          end
        end
      end
    end
  end
end
