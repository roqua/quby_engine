require 'spec_helper'

module Quby
  describe QuestionOption do

    let(:valid_questionnaire) do
      questionnaire = Quby::Questionnaire.new("test", <<-END)
        question :one, :type => :radio do
          title "Testvraag"
          option :a1, :hides_questions => [:two]
          option :a2, :hides_questions => [:three]
          option :a3, :hides_questions => [:four]
          option :a4, :shows_questions => [:five]
        end

        question :two, :type => :radio
        question :three, :type => :radio
        question :four, :type => :radio
        question :five, :type => :radio
      END
      questionnaire
    end

    let(:invalid_questionnaire) do
      questionnaire = Quby::Questionnaire.new("test2")
      questionnaire.stub(:definition).and_return(<<-END)
        question :one, :type => :radio do
          title "Testvraag"
          option :a1, :hides_questions => [:two]
        end
      END
      questionnaire
    end

    describe ":hides_questions" do
      it "throws an error if the question to be hidden does not exist" do
        invalid_questionnaire.valid?.should be_false
      end
    end

    describe ".unhides_questions" do
      it "returns an array with the keys of the questions that are unhidden when this option is picked" do
        valid_questionnaire.question_hash[:one].options.first.unhides_questions.should == [:three, :four]
        valid_questionnaire.question_hash[:one].options[-2].unhides_questions.should == [:two, :three]
      end
    end

    describe ".hides_questions" do
      it "returns an array with the keys of the questions that are hidden when this option is picked" do
        valid_questionnaire.question_hash[:one].options.first.hides_questions.should == [:two]
      end
    end

    describe ".shows_questions" do
      it "returns an array with the keys of the questions that are shown when this option is picked" do
        valid_questionnaire.question_hash[:one].options.last.shows_questions.should == [:five]
      end
    end
  end
end