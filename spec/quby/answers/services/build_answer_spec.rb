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

      it 'fails if textvar without default is not given' do
        questionnaire = inject_questionnaire 'test', <<-END
          textvar key: 'foo', description: ''
        END

        expect do
          BuildAnswer.new(questionnaire, {}).build
        end.to raise_error
      end
    end
  end
end
