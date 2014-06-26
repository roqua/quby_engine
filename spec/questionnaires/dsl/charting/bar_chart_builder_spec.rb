require 'spec_helper'

module Quby
  module DSL
    describe BarChartBuilder do
      it_behaves_like ChartBuilder

      let(:questionnaire) { double(key: 'questionnaire_key') }

      it 'makes a bar chart' do
        dsl { }.should be_an_instance_of(::Quby::Charting::BarChart)
      end

      def dsl(key = :test, options = {}, &block)
        builder = BarChartBuilder.new(questionnaire, key, options)
        builder.build(&block)
      end
    end
  end
end
