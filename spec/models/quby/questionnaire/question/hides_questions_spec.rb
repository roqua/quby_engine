require 'spec_helper'

module Quby
  describe Items::Question do
    describe "#hides_questions" do

      it "throws an error if the question to be hidden does not exist" do
        @questionnaire = Quby::Questionnaire.new("test")
        @questionnaire.stub(:definition).and_return(<<-END)
          question :one, :type => :radio do
            title "Testvraag"
            option :a1, :hides_questions => [:two]
          end
        END

        lambda{@questionnaire.enhance_by_dsl}.should raise_error
      end
    end
  end
end