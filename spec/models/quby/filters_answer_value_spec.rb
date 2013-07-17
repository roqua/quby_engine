require 'spec_helper'

module Quby
  describe FiltersAnswerValue do
    let(:question)         { double("Question", key: :v_6) }
    let(:questionnaire)    { double("Questionnaire", questions: [question]) }
    let(:attribute_filter) { FiltersAnswerValue.new questionnaire }

    describe '#update' do
      it 'sets answer value for the provided key to the provided value' do
        expect(attribute_filter.filter("v_6" => "value")).to eq({"v_6" => "value"})
      end

      it 'disallows setting attributes that are not questions' do
        expect(attribute_filter.filter("random_key" => "value")).to eq({})
      end

      it 'passes through activity_log' do
        expect(attribute_filter.filter("activity_log" => "value")).to eq({"activity_log" => "value"})
      end
    end
  end
end
