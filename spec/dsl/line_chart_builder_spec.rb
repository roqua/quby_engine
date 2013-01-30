require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe LineChartBuilder do
      it 'makes a line chart' do
        dsl { }.should be_an_instance_of(LineChart)
      end

      def dsl(key = :test, options = {}, &block)
        builder = LineChartBuilder.new(key, options)
        builder.build(&block)
      end
    end
  end
end
