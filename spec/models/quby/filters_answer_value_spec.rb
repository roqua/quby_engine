require 'spec_helper'

module Quby
  describe FiltersAnswerValue do
    let(:question)          { double("Question", key: :v_6, type: :radio) }
    let(:checkbox_question) { double("Question", key: :v_7, type: :check_box,
                                                 options: [double("QuestionOption", key: "v_7a1"),
                                                           double("QuestionOption", key: "v_7a2")]) }
    let(:questionnaire) do
      q = Questionnaire.new :filter_test
      q.stub questions: [question, checkbox_question, nil]
      q
    end

    let(:attribute_filter) { FiltersAnswerValue.new questionnaire }

    describe '#update' do
      it 'sets answer value for the provided key to the provided value' do
        expect(attribute_filter.filter("v_6" => "value")).to eq("v_6" => "value")
      end

      it 'disallows setting attributes that are not questions' do
        expect(attribute_filter.filter("random_key" => "value")).to eq({})
      end

      it 'passes through activity_log' do
        expect(attribute_filter.filter("activity_log" => "value")).to eq("activity_log" => "value")
      end

      it 'passes through aborted' do
        expect(attribute_filter.filter("aborted" => "value")).to eq("aborted" => "value")
      end

      it 'allows checkbox options' do
        expect(attribute_filter.filter("v_7" => "value")).to eq("v_7" => "value")
        expect(attribute_filter.filter("v_7a1" => "value")).to eq("v_7a1" => "value")
        expect(attribute_filter.filter("v_7a2" => "value")).to eq("v_7a2" => "value")
      end
    end
  end
end
