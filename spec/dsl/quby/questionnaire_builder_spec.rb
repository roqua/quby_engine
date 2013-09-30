require 'spec_helper'

module Quby
  module QuestionnaireDsl
    describe QuestionnaireBuilder do
      let(:questionnaire) { ::Quby::Questionnaire.new("example") }
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
        expect {
          dsl do
            question :v_1, type: :string
            question :v_1, type: :string
          end
        }.to raise_exception
      end

      it 'checks for duplicate checkbox option keys' do
        expect {
          dsl do
            question :v_1, type: :string
            question :v_2, type: :check_box do
              option :v_1
            end
          end
        }.to raise_exception
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

      def dsl(&block)
        builder.instance_eval(&block)
      end
    end
  end
end