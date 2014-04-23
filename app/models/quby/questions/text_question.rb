module Quby
  module Questions
    class TextQuestion < Quby::Items::Question
      def as_json(options = {})
        super.merge(autocomplete: @autocomplete)
      end
    end
  end
end
