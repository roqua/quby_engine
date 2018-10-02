# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Services
  describe BuildAnswer do
    let(:questionnaire) { Quby.questionnaires.find('simple') }

    it 'sets questionnaire key' do
      answer = BuildAnswer.new(questionnaire, {}).build
      expect(answer.questionnaire_key).to eq('simple')
    end

    describe 'textvars' do
      it 'sets default textvar values' do
        questionnaire = inject_questionnaire 'test', <<-END
          textvar key: 'foo', description: '', default: 'some_default'
        END

        answer = BuildAnswer.new(questionnaire, {}).build
        expect(answer.textvars).to eq({test_foo: 'some_default'})
      end

      it 'sets given textvar values' do
        questionnaire = inject_questionnaire 'test', <<-END
          textvar key: 'foo', description: '', default: 'some_default'
        END

        answer = BuildAnswer.new(questionnaire, {textvars: {test_foo: 'something_given'}}).build
        expect(answer.textvars).to eq({test_foo: 'something_given'})
      end

      it 'without default are replaced with {{text_var_key}}' do
        questionnaire = inject_questionnaire 'test', <<-END
          textvar key: 'foo', description: ''
        END

        answer = BuildAnswer.new(questionnaire, {}).build
        expect(answer.textvars).to eq({test_foo: '{{test_foo}}'})
      end
    end
  end
end
