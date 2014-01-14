require 'spec_helper'

module Quby
  describe QuestionOption do
    let(:questionnaire) do
      questionnaire = Quby::Questionnaire.new("test", <<-END)
        question :one, type: :radio do
          title "Testvraag"
          option :a1, hides_questions: [:two]
          option :a2, hides_questions: [:three]
          option :a3, hides_questions: [:four]
          option :a4, shows_questions: [:five]
        end

        question :two, type: :radio
        question :three, type: :radio
        question :four, type: :radio
        question :five, type: :radio

        question :checkb, type: :check_box do
          title "Checkbox vraag"
          option :sixone
          option :sixtwo
        end
      END
      questionnaire
    end

    describe "#hides_questions" do
      it "returns an array with the keys of the questions that are hidden when this option is picked" do
        questionnaire.question_hash[:one].options.first.hides_questions.should == [:two]
      end
    end

    describe "#shows_questions" do
      it "returns an array with the keys of the questions that are shown when this option is picked" do
        questionnaire.question_hash[:one].options.last.shows_questions.should == [:five]
      end
    end

    describe "#input_key" do
      it 'returns the key for checkbox questions' do
        option = questionnaire.question_hash[:checkb].options.first
        expect(option.input_key).to eq :sixone
      end

      it 'returns <question_key>_<option_key> for radio questions' do
        option = questionnaire.question_hash[:one].options.first
        expect(option.input_key).to eq :one_a1
      end
    end
  end
end
