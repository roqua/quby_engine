require 'spec_helper'

describe Questionnaire do
  describe "validating using" do
    describe "validates_format_with" do
      before(:each) do
        @questionnaire = Questionnaire.new
        @questionnaire.stub(:definition).and_return(<<-END)
          question :one, :type => :string do
            title "Testvraag"
            validates_format_with /right/
          end

          question :two, :type => :string do
            title "Vraag 2"
            validates_format_with /qwerty/, :message => "should contain qwerty"
          end
        END
        @questionnaire.enhance_by_dsl
        @answer = Answer.new(:questionnaire => @questionnaire)
      end

      it "should add a validation to the question" do
        @questionnaire.questions[0].validations.should_not be_empty
        @questionnaire.questions[1].validations.should_not be_empty
      end

      it "should check if the value matches the regexp" do
        @answer.value = {:one => "right"}
        @answer.validate_answers
        @answer.errors[:one].any?.should be_false

        @answer.value = {:one => "wrong"}
        @answer.validate_answers
        @answer.errors[:one].any?.should be_true
      end

      it "should add a message if passed" do
        @answer.value = {:one => "right", :two => "wrong"}
        @answer.validate_answers
        @answer.errors[:two].any?.should be_true
        puts @answer.errors[:two].inspect
        @answer.errors[:two].map{|i| i[:message] }.should include("should contain qwerty")
      end
    end
  end
end