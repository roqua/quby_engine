require 'spec_helper'

module Quby
  describe DefinitionValidator do
    let(:questionnaire) { Questionnaire.new('test') }

    describe ":hides_questions" do
      it "throws an error if the question to be hidden does not exist" do
        invalid_definition = <<-END
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, hides_questions: [:v_2]
          end
        END
        DefinitionValidator.new(questionnaire, invalid_definition).validate
        expect(questionnaire.errors[:definition].first[:message])
          .to include("Question v_1 option a1 hides nonexistent question v_2")
      end

      it 'does not throw an error when the question to be hidden exists' do
        definition = <<-END
          question :v_1, type: :radio do
            title "Testvraag"
            option :a1, hides_questions: [:v_2]
          end

          question :v_2, type: :text
        END
        expect(DefinitionValidator.new(questionnaire, definition).validate).to be_true
      end
    end

    describe ":validates_question_key_format" do
      it "validates length of the question keys" do
        long_key = <<-END
          question :questionthree, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        valid_key = <<-END
          question :v_2, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        DefinitionValidator.new(questionnaire, long_key).validate.should be_false
        DefinitionValidator.new(questionnaire, valid_key).validate.should be_true
      end

      it "validates that question key starts with a `v_`" do
        invalid_key = <<-END
          question :one, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description', hides_questions: [:two]
          end
        END
        valid_key = <<-END
          question :v_2, type: :radio do
            title "Testvraag"
            option :a1, description: 'some_description'
          end
        END
        DefinitionValidator.new(questionnaire, invalid_key).validate.should be_false
        DefinitionValidator.new(questionnaire, valid_key).validate.should be_true
      end

      it "validates check_box question options start with `v_`" do
        invalid_keys = <<-END
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :q1, description: 'some_description'
          end
        END
        valid_keys = <<-END
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1, description: 'some_description'
          end
        END
        DefinitionValidator.new(questionnaire, invalid_keys).validate.should be_false
        DefinitionValidator.new(questionnaire, valid_keys).validate.should be_true
      end

      it "validates check_box question options length" do
        invalid_keys = <<-END
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1_has_a_very_long_key, description: 'some_description'
          end
        END
        valid_keys = <<-END
          question :v_4, type: :check_box do
            title "Testvraag met een check_box"
            option :v_q1, description: 'some_description'
          end
        END
        DefinitionValidator.new(questionnaire, invalid_keys).validate.should be_false
        DefinitionValidator.new(questionnaire, valid_keys).validate.should be_true
      end

      it "validates question date keys" do
        invalid_keys = <<-END
          question :v_6, type: :date, year_key: :invalid_key, month_key: :v_62, day_key: :v_63 do
            title "Testvraag met een datum"
          end
        END
        valid_keys = <<-END
          question :v_6, type: :date, year_key: :v_61, month_key: :v_62, day_key: :v_63 do
            title "Testvraag met een datum"
          end
        END
        DefinitionValidator.new(questionnaire, invalid_keys).validate.should be_false
        DefinitionValidator.new(questionnaire, valid_keys).validate.should be_true
      end
    end
  end
end
