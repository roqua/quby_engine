require 'spec_helper'

module Quby::Questionnaires::DSL
  describe QuestionnaireBuilder do
    let(:questionnaire) { Quby::Questionnaires::Entities::Questionnaire.new("example") }
    let(:builder)       { QuestionnaireBuilder.new(questionnaire) }

    it 'sets title' do
      dsl { title 'Foo' }
      questionnaire.title.should == 'Foo'
    end

    it 'sets description' do
      dsl { description 'This is a questionnaire description' }
      questionnaire.description.should == 'This is a questionnaire description'
    end

    it 'sets outcome_description' do
      dsl { outcome_description 'Outcome description' }
      questionnaire.outcome_description.should == 'Outcome description'
    end

    it 'can be abortable' do
      questionnaire.abortable.should be_false
      dsl { abortable }
      questionnaire.abortable.should be_true
    end

    it 'can allow hotkeys' do
      dsl { allow_hotkeys }
      questionnaire.allow_hotkeys.should == "all"
    end

    it 'can set license' do
      dsl { license :free }
      expect(questionnaire.license).to eq(:free)
    end

    it 'builds panels' do
      dsl { panel { title 'My Title' } }
      questionnaire.panels.first.title.should == 'My Title'
    end

    it 'builds line charts' do
      dsl { line_chart(:tot) { title 'My Title'; range 0..40 } }
      questionnaire.charts.find(:tot).title.should == 'My Title'
    end

    it 'builds bar charts' do
      dsl { bar_chart(:tot) { title 'My Title' } }
      questionnaire.charts.find(:tot).title.should == 'My Title'
    end

    it 'builds radar charts' do
      dsl { radar_chart(:tot) { title 'My Title' } }
      questionnaire.charts.find(:tot).title.should == 'My Title'
    end

    it 'checks for duplicate question keys' do
      expect do
        dsl do
          question :v_1, type: :string
          question :v_1, type: :string
        end
      end.to raise_exception
    end

    it 'checks for subquestion clashing with parent question' do
      pending
      expect do
        dsl do
          question :v_1, type: :radio do
            option :a1 do
              question :v_1, type: :string
            end
          end
        end
      end.to raise_exception
    end

    it 'checks for duplicate option keys' do
      expect do
        dsl do
          question :v_1, type: :radio do
            option :a1
            option :a1
          end
        end
      end.to raise_exception
    end

    it 'checks for duplicate option input keys' do
      expect do
        dsl do
          question :v_1_a, type: :radio do
            option :a1
          end

          question :v_1, type: :radio do
            option :a_a1
          end
        end
      end.to raise_exception
    end

    it 'checks for checkbox option keys clashing with question keys' do
      expect do
        dsl do
          question :v_1, type: :string
          question :v_2, type: :check_box do
            option :v_1
          end
        end
      end.to raise_exception
    end

    it 'checks for checkbox option keys clashing with their own question key' do
      expect do
        dsl do
          question :v_1, type: :check_box do
            option :v_2
            option :v_1
          end
        end
      end.to raise_exception
    end

    it 'checks for checkbox option keys clashing with input keys' do
      expect do
        dsl do
          question :v_1, type: :radio do
            option :a1
          end
          question :v_2, type: :check_box do
            option :v_1_a1
          end
        end
      end.to raise_exception
    end

    it 'sets a depends_on key correctly' do
      dsl do
        question :v_1, type: :check_box do
          option :v_1_a
        end
        question :v_2, type: :string, depends_on: [:v_1]
      end
      questionnaire.callback_after_dsl_enhance_on_questions
      expect(questionnaire.question_hash[:v_2].depends_on).to eq [:v_1_a]
    end

    it 'raises when a depends_on key does not exist in the questionnaire' do
      expect do
        dsl do
          question :v_1, type: :string, depends_on: [:unknown]
        end
        questionnaire.callback_after_dsl_enhance_on_questions
      end.to raise_exception
    end

    it 'sets the parent option key on subquestions correctly' do
      dsl do
        question :v_1, type: :check_box do
          option :v_1a do
            question :v_2, type: :string
          end
          option :v_1b
        end
      end
      questionnaire.question_hash[:v_2].parent_option_key.should == :v_1a
    end

    describe 'flag' do
      before do
        Quby::Questionnaires::Entities::Questionnaire.any_instance.stub(:add_flag)
      end

      it 'defines flags' do
        dsl do
          flag key: :test, description: 'test flag'
        end
        expect(questionnaire).to have_received(:add_flag).with(key: :test, description: 'test flag')
      end
    end

    def dsl(&block)
      builder.instance_eval(&block)
    end
  end
end
