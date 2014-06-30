module Quby
  module Questionnaires
    module Entities
      module Questions
        class DateQuestion < Items::Question
          # For optionally giving year, month and day fields of dates their own keys
          attr_accessor :year_key
          attr_accessor :month_key
          attr_accessor :day_key

          def initialize(key, options = {})
            super

            @year_key  = options[:year_key].andand.to_s
            @month_key = options[:month_key].andand.to_s
            @day_key   = options[:day_key].andand.to_s
          end

          def year_key
            (@year_key || "#{key}_yyyy").to_s
          end

          def month_key
            (@month_key || "#{key}_mm").to_s
          end

          def day_key
            (@day_key || "#{key}_dd").to_s
          end

          def input_keys
            [day_key.to_sym, month_key.to_sym, year_key.to_sym]
          end

          def answer_keys
            [day_key.to_sym, month_key.to_sym, year_key.to_sym]
          end

          def as_json(options = {})
            super.merge(year_key: year_key, month_key: month_key, day_key: day_key)
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
