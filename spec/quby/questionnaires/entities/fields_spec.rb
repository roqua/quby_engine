# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  describe Fields do
    let(:key)           { 'test' }
    let(:definition) do
      %q~
        question :v_1, type: :check_box, title: 'select a few' do
          option :v_1_a1, description: 'select me' do
            question :v_1_a1_1, type: :string, title: 'why did you do that?'
          end
        end
        question :v_2, type: :radio, title: 'choose one' do
          option :a1, value: 1, description: 'me'
        end
      ~
    end
    let(:questionnaire) { Quby::Questionnaires::DSL.build(key, definition) }

    describe 'question_hash' do
      it 'contains all the questions by question_key' do
        expect(questionnaire.fields.question_hash[:v_1].title).to eq 'select a few'
        expect(questionnaire.fields.question_hash[:v_1_a1_1].title).to eq 'why did you do that?'
      end
    end

    describe 'option_hash' do
      it 'contains all the options by input_key' do
        expect(questionnaire.fields.option_hash[:v_1_a1].description).to eq 'select me'
        expect(questionnaire.fields.option_hash[:v_2_a1].description).to eq 'me'
      end
    end

    describe 'input_keys' do
      it 'contains all the used input_keys' do
        expect(questionnaire.fields.input_keys).to eq Set.new(%I( v_1_a1 v_1_a1_1 v_2_a1 ))
      end
    end

    describe 'answer_keys' do
      it 'contains all the used answer_keys' do
        expect(questionnaire.fields.answer_keys).to eq Set.new(%I( v_1_a1 v_1_a1_1 v_2 ))
      end
    end

    describe '#add' do
      describe 'if a subquestion clashes with its parent option key' do
        let(:definition) do
          %q~
        question :v_1, type: :radio, title: 'select a few' do
          option :a1, description: 'select me' do
            question :v_1_a1, type: :textarea, title: 'why did you do that?'
          end
          option :a2, description: 'select me not'
        end
      ~
        end
        it 'raises' do
          expected_exception = 'Duplicate input keys: #<Set: {:v_1_a1}>'
          expect { questionnaire }.to raise_exception(expected_exception)
        end

        describe 'if questionnaire.check_key_clashes is false' do
          let(:definition) do
            %q~
            do_not_check_key_clashes
            question :v_1, type: :radio, title: 'select a few' do
              option :a1, description: 'select me' do
                question :v_1_a1, type: :textarea, title: 'why did you do that?'
              end
              option :a2, description: 'select me not'
            end
            ~
          end
          it 'does not raise' do
            expect { questionnaire }.to_not raise_exception
          end
        end
      end
    end
  end
end
