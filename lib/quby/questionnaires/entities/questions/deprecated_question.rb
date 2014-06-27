module Quby
  module Questions
    class DeprecatedQuestion < Quby::Items::Question
      def hidden?
        true
      end

      def as_json(options = {})
        super.merge(options: @options.as_json)
      end
    end
  end
end
