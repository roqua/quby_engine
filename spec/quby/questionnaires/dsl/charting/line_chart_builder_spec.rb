require 'spec_helper'

module Quby::Questionnaires::DSL
  describe LineChartBuilder do
    it_behaves_like ChartBuilder

    let(:questionnaire) { double(key: 'questionnaire_key') }

    it 'sets y-axis label' do
      expect(dsl { y_axis_label 'Label' }.y_label).to eq 'Label'
    end

    it 'sets y-axis range' do
      expect(dsl { range 0..40 }.y_range).to eq (0..40)
    end

    it 'sets y-axis tick interval' do
      expect(dsl { tick_interval 1 }.tick_interval).to eq 1
    end

    it 'raises when y-axis range is not specified' do
      expect { dsl(:test, {}) { } }.to raise_error(/no range specified/)
    end

    it 'sets tonality' do
      expect(dsl { tonality :higher_is_better }.tonality).to eq :higher_is_better
    end

    it 'sets baseline to constant value' do
      expect(dsl { baseline 5 }.baseline.call(1, :male)).to eq 5.0
    end

    it 'sets baseline to proc' do
      expect(dsl { baseline { |age, gender| age } }.baseline.call(5, :male)).to eq(5.0)
      expect { dsl { baseline { |age| age } } }.to raise_error(ArgumentError, /must take two arguments/)
    end

    it 'raises error if not giving baseline value or block' do
      expect { dsl { baseline } }.to raise_error(ArgumentError, /either value or a block/)
      expect { dsl { baseline(5.0) { |age, gender| age } } }.to raise_error(ArgumentError, /either value or a block/)
    end

    it 'sets clinically relevant change' do
      expect(dsl { clinically_relevant_change 5 }.clinically_relevant_change).to eq 5.0
    end

    it 'makes a line chart' do
      expect(dsl { }).to be_an_instance_of(::Quby::Questionnaires::Entities::Charting::LineChart)
    end

    def dsl(key = :test, options = {y_range: (0..20)}, &block)
      builder = LineChartBuilder.new(questionnaire, key, options)
      builder.build(&block)
    end
  end
end
