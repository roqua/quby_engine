module Quby
  module QuestionnaireDsl
    class BarChartBuilder
      def initialize(questionnaire, key, options = {})
        @chart = ::Quby::Charting::BarChart.new(key, options = {})
        @questionnaire = questionnaire
      end

      def title(title)
        @chart.title = title
      end

      def scores(*keys)
        missing_score_keys = keys.reject {|key| @questionnaire.find_score(key) }
        raise "Chart #{@chart.key} references unknown scores #{missing_score_keys}" if missing_score_keys.present?

        @chart.scores = keys.map {|key| @questionnaire.find_score(key) }
      end

      def build(&block)
        instance_eval &block
        @chart
      end
    end
  end
end