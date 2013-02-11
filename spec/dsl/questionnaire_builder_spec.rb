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
        dsl { line_chart(:tot) { title 'My Title' } }
        questionnaire.charts.find(:tot).title.should == 'My Title'
      end

      it 'builds bar charts' do
        dsl { bar_chart(:tot) { title 'My Title' } }
        questionnaire.charts.find(:tot).title.should == 'My Title'
      end

      def dsl(&block)
        builder.instance_eval(&block)
      end
    end
  end
end