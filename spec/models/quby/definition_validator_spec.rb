require 'spec_helper'

module Quby
  describe DefinitionValidator do
    let(:questionnaire) { Questionnaire.new('test') }
    let(:invalid_definition) do
      <<-END
        question :one, :type => :radio do
          title "Testvraag"
          option :a1, :hides_questions => [:two]
        end
      END
    end

    describe ":hides_questions" do
      it "throws an error if the question to be hidden does not exist" do
        DefinitionValidator.new(questionnaire, invalid_definition).validate.should be_false
      end
    end
  end
end