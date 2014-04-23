module Quby
  module Questions
    class RadioQuestion < Quby::Items::Question
      def as_json(options = {})
        super.merge(options: @options.as_json)
      end

      def codebook_output_type
        :radio
      end
    end
  end
end
