require 'spec_helper'

module Quby
  describe Items::Question do

    let(:questionnaire) do
      questionnaire = Quby::Questionnaire.new("test", <<-END)
        question :radio, type: :radio, depends_on: [:check] do
          title "Testvraag"
          option :rad1
          option :rad2
        end

        question :check, type: :check_box do
          title "Checkbox vraag"
          option :check1
          option :check2
        end

        question :int, type: :integer

        question :date, type: :date
      END
      questionnaire
    end

    describe "validations" do
      it "should require an answer to a required question"
      it "should not require an answer to an unrequired question"
    end

    describe '#input_keys' do
      it 'should list all input keys' do
        expect(questionnaire.question_hash[:radio].input_keys).to eql [:radio_rad1, :radio_rad2]
        expect(questionnaire.question_hash[:check].input_keys).to eql [:check1, :check2]
        expect(questionnaire.question_hash[:int].input_keys).to eql [:int]
        expect(questionnaire.question_hash[:date].input_keys).to eql [:date_dd, :date_mm, :date_yyyy]
      end
    end

    describe '#expand_depends_on_input_keys' do
      it 'should expand the given depends_on keys' do
        expect(questionnaire.question_hash[:radio].depends_on).to eq [:check1, :check2]
      end
    end

  end
end
