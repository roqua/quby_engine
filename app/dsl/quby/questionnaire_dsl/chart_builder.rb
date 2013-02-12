module Quby
  module QuestionnaireDsl
    class ChartBuilder
      def self.set_chart_class(chart_class)
        @chart_class = chart_class
      end

      def self.chart_class
        @chart_class
      end

      def initialize(questionnaire, key, options = {})
        @chart = self.class.chart_class.new(key, options = {})
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

      def chart_type(type)
        @chart.chart_type = type
      end

      def score_sub_key(key)
        @chart.score_sub_key = key
      end

      def build(&block)
        instance_eval &block
        @chart
      end
    end
  end
end