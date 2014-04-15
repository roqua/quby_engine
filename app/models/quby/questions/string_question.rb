module Quby
  module Questions
    class StringQuestion < Quby::Items::Question
      def as_json
        super.merge(autocomplete: @autocomplete)
      end
    end
  end
end
