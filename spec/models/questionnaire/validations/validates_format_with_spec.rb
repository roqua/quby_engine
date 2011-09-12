require 'spec_helper'

describe Questionnaire do
  describe "validating using" do
    describe "validates_format_with" do
      before(:each) do
        @questionnaire = Questionnaire.new
        @questionnaire.stub(:definition).and_return(<<-END)
          question :one, :type => :string do
            title "Testvraag"
            validates_format_with /aabb/
          end
        END
        @questionnaire.enhance_by_dsl
        @answer = Answer.new(:questionnaire => @questionnaire)
      end

      it "should add a validation to the question" do
        @questionnaire.questions.first.validations.should_not be_empty
      end

      it "should check if the value matches the regexp" do
        @answer.value = {:one => "aabb"}
        @answer.validate_answers
        @answer.errors.should be_empty

        @answer.value = {:one => "foo"}
        @answer.validate_answers
        @answer.errors.should_not be_empty
      end
    end
  end
end