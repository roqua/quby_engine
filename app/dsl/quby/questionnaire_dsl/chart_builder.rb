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

      def plot(key, plotted_key = :value)
        begin
          score = @questionnaire.find_score(key)
        rescue KeyError
          raise "Questionnaire #{@questionnaire.key} chart #{@chart.key} references unknown score #{key}"
        end
        @chart.scores << Quby::Charting::PlottedScore.new(score.key, label: score.label, plotted_key: plotted_key)
      end

      def chart_type(type)
        @chart.chart_type = type
      end

      def build(&block)
        instance_eval(&block)
        @chart
      end
    end
  end
end