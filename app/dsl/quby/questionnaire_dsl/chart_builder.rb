module Quby
  module QuestionnaireDsl
    class ChartBuilder
      # rubocop:disable AccessorMethodName
      def self.set_chart_class(chart_class)
        @chart_class = chart_class
      end
      # rubocop:enable AccessorMethodName

      def self.chart_class
        @chart_class
      end

      def initialize(questionnaire, key, options = {})
        @chart = self.class.chart_class.new(key, options)
        @questionnaire = questionnaire
      end

      def title(title)
        @chart.title = title
      end

      def plot(key, options = {})
        unless plottable = @questionnaire.find_plottable(key)
          raise "Questionnaire #{@questionnaire.key} chart #{@chart.key} references unknown score or question #{key}"
        end

        configure_options plottable, options

        @chart.plottables << Quby::Charting::Plottable.new(plottable.key, options)
      end

      def chart_type(type)
        @chart.chart_type = type
      end

      def build(&block)
        instance_eval(&block)
        validate!
        @chart
      end

      def validate!
        true
      end

      private

      def configure_options(plottable, options)
        case plottable
        when Quby::Score
          options.reverse_merge! plottable.options
        when Quby::Items::Question
          options[:label] ||= plottable.title
        end
        options[:questionnaire_key] = @questionnaire.key
      end
    end
  end
end
