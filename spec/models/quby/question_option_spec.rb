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
      END
      questionnaire
    end

    describe ".hides_questions" do
      it "returns an array with the keys of the questions that are hidden when this option is picked" do
        questionnaire.question_hash[:one].options.first.hides_questions.should == [:two]
      end
    end

    describe ".shows_questions" do
      it "returns an array with the keys of the questions that are shown when this option is picked" do
        questionnaire.question_hash[:one].options.last.shows_questions.should == [:five]
      end
    end
  end
end