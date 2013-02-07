require 'spec_helper'

module Quby
  describe Questionnaire do
    describe "validating using" do
      describe "validates_format_with" do
        before(:each) do
          @questionnaire = Quby::Questionnaire.new("test")
          @questionnaire.stub(:definition).and_return(<<-END)
            question :v_1, :type => :string do
              title "Testquestion"
              validates_format_with /right/
            end

            question :v_2, :type => :string do
              title "Question 2"
              validates_format_with /qwerty/, :message => "should contain qwerty"
            end

            question :v_3, :type => :radio do
              title "Question 3 with title question"
              title_question :v_3_01, :type => :string, :title => "Geef aan:", :depends_on => [:v_3_a2]

              option :a1, :value => 0
              option :a2, :value => 1
            end

            question :v_4, :type => :radio do
              title "Question 4 with subquestion"
              option :a1, :value => 0 do
                question :v_4_01, :type => :string
              end
              option :a2, :value => 1
            end
          END
          @questionnaire.enhance_by_dsl
          Answer.any_instance.stub(:questionnaire).and_return(@questionnaire)
          @answer = Answer.new
          @answer.extend AnswerValidations
        end

        it "should add a validation to the question" do
          @questionnaire.questions[0].validations.should_not be_empty
          @questionnaire.questions[1].validations.should_not be_empty
        end

        it "should check if the value matches the regexp" do
          @answer.value = {"v_1" => "right"}
          @answer.validate_answers
          @answer.errors[:one].any?.should be_false

          @answer.value = {"v_1" => "wrong"}
          @answer.validate_answers
          @answer.errors[:v_1].any?.should be_true
        end

        it "should add a message if passed" do
          @answer.value = {"v_1" => "right", "v_2" => "wrong"}
          @answer.validate_answers
          @answer.errors[:v_2].any?.should be_true
          @answer.errors[:v_2].map{|i| i[:message] }.should include("should contain qwerty")
        end

        it "preserves title questions" do
          @answer.value = {"v_3_01" => "answer"}
          @answer.validate_answers
          @answer.value["v_3_01"].should == "answer"
        end

        it "preserves subquestions if the parent option is ticked" do
          @answer.value = {"v_4" => "a1", "v_4_01" => "answer"}
          @answer.validate_answers
          @answer.value["v_4_01"].should == "answer"
        end

        it "deletes subquestions of options that are not ticked" do
          @answer.value = {"v_4_01" => "answer"}
          @answer.validate_answers
          @answer.value["v_4_01"].should be_nil
        end
      end
    end
  end
end