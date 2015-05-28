require 'spec_helper'

module Quby::Answers::Services
  describe FiltersAnswerValue do

    let(:questionnaire) do
      Quby::Questionnaires::DSL.build("test") do
        question :v_6, type: :radio do
          title "Testvraag"
          option :rad1
          option :rad2
        end

        question :v_7, type: :check_box do
          title "Checkbox vraag"
          option :v_7a1
          option :v_7a2
        end

        question :date, type: :date
      end
    end

    let(:attribute_filter) { FiltersAnswerValue.new questionnaire }

    let(:empty_hash) do
      {
        "aborted"=>nil, "v_6"=>nil, "v_7a1"=>nil, "v_7a2"=>nil,
        "date_dd"=>nil, "date_mm"=>nil, "date_yyyy"=>nil
      }
    end

    describe '#update' do
      it 'sets answer value for the provided key to the provided value' do
        expect(attribute_filter.filter("v_6" => "value")).to eq(empty_hash.merge("v_6" => "value"))
      end

      it 'disallows setting attributes that are not questions' do
        expect(attribute_filter.filter("random_key" => "value")).to eq(empty_hash)
      end

      it 'passes through aborted' do
        expect(attribute_filter.filter("aborted" => "value")).to eq(empty_hash.merge("aborted" => "value"))
      end

      it 'allows checkbox options' do
        # expect(attribute_filter.filter("v_7" => "value")).to eq("v_7" => "value")
        expect(attribute_filter.filter("v_7a1" => "value")).to eq(empty_hash.merge("v_7a1" => "value"))
        expect(attribute_filter.filter("v_7a2" => "value")).to eq(empty_hash.merge("v_7a2" => "value"))
      end

      it 'does not mutate the original hash' do
        hash = {"foo" => "bar"}
        expect(attribute_filter.filter(hash)).to eq(empty_hash)
        expect(hash).to eq("foo" => "bar")
      end
    end
  end
end
