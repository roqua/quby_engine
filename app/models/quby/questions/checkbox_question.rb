module Quby
  module Questions
    class CheckboxQuestion < Quby::Items::Question
      # checkbox option that checks all other options on check
      attr_accessor :check_all_option
      # checkbox option that unchecks all other options on check
      attr_accessor :uncheck_all_option

      def initialize(key, options = {})
        super

        @check_all_option = options[:check_all_option]
        @uncheck_all_option = options[:uncheck_all_option]

        if @check_all_option
          @validations << {type: :not_all_checked, check_all_key: @check_all_option,
                           explanation: options[:error_explanation]}
        end

        if @uncheck_all_option
          @validations << {type: :too_many_checked, uncheck_all_key: @uncheck_all_option,
                           explanation: options[:error_explanation]}
        end
      end

      def answer_keys
        # Some options don't have a key (inner_title), they are stripped.
        options.map { |opt| opt.input_key }.compact
      end

      def as_json(options = {})
        super.merge(options: @options.as_json)
      end

      def to_codebook(questionnaire, opts = {})
        output = []
        options.each_with_index do |option, idx|
          next if option.inner_title

          output << "#{codebook_key(option.key, questionnaire, opts)} #{codebook_output_type}"
          output << "\"#{title} -- #{option.description}\"" unless title.blank? and option.description.blank?
          output << "1\tChecked"
          output << "0\tUnchecked"
          output << "empty\tUnchecked"
          output << "" unless idx == (options.size - 1)
        end
        output.join("\n")
      end
    end
  end
end
