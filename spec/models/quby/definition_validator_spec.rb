require 'spec_helper'

module Quby
  describe DefinitionValidator do
    let(:questionnaire) { Questionnaire.new('test') }
    let(:invalid_definition) do
      <<-END
        question :one, type: :radio do
          title "Testvraag"
          option :a1, hides_questions: [:two]
        end
      END
    end

    describe ":hides_questions" do
      it "throws an error if the question to be hidden does not exist" do
        DefinitionValidator.new(questionnaire, invalid_definition).validate.should be_false
      end
    end

    describe ":validates_question_key_format" do

      long_key = <<-END
          question :morethanten, type: :radio do
            title "Testvraag"
            option :a1
          end
        END

      short_key = <<-END
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1
          end
        END

      it "validates length of the question keys" do
        DefinitionValidator.new(questionnaire, long_key).validate.should be_false
        DefinitionValidator.new(questionnaire, short_key).validate.should be_true
      end

      it "validates that question key starts with a `v_`" do
        DefinitionValidator.new(questionnaire, short_key).validate.should be_true
      end
    end
  end
end
