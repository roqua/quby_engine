# frozen_string_literal: true

require 'spec_helper'

module Quby::Compiler::Entities
  describe Fields do
    let(:key) { 'test' }
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
    let(:questionnaire) { Quby::Compiler::DSL.build(key, definition) }

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

    describe '#description_for_variable' do
      let(:definition) do
        %q~
          flag key: :flagtest, description_true: 'it true', description_false: 'it false', description: 'it described'
          textvar key: :textvartest, description: 'tv description'
          question :v_1, type: :radio, title: 'select a few'
          question :v_2, type: :radio, title: 'select a few' do
            context_free_title 'select a few things'
          end
          question :v_3, type: :date, title: 'Belangrijke datum', components: %i( day month year hour minute )
          question :v_4, type: :check_box do
            title "Which?"
            option :v_4a1, description: 'option a1'
            inner_title 'Really?'
            option :v_4a2, description: 'option a2'
          end

          score :tot, label: 'Total' do
            {value: 2, interpretation: 'Very high'}
          end

          score_schema :tot, 'Total', [{key: :value, export_key: 'tot', label: 'Score'},
                                       {key: :interpretation, export_key: 'tot_i', label: 'Interpretation'}]

        ~
      end

      it 'returns question context free titles if the variable is a question' do
        expect(questionnaire.fields.description_for_variable('v_1')).to eq('select a few')
        expect(questionnaire.fields.description_for_variable('v_2')).to eq('select a few things')
      end
      it 'returns checkbox option descriptions if the variable is a checkbox option' do
        keys = %w(v_4 v_4a1 v_4a2)
        expect(keys.map { |key| questionnaire.fields.description_for_variable key }).to \
          eq(['Which?', 'Which? - option a1', 'Which? - option a2'])
      end
      it 'returns date question descriptions if the variable is a date question\'s subcomponent' do
        keys = %w(v_3 v_3_dd v_3_mm v_3_yyyy v_3_hh v_3_ii)
        expect(keys.map { |key| questionnaire.fields.description_for_variable key }).to \
          eq(["Belangrijke datum", "Belangrijke datum (dag)", "Belangrijke datum (maand)",
              "Belangrijke datum (jaar)", "Belangrijke datum (uur)", "Belangrijke datum (minuut)"])
      end
      it 'returns score labels if the variable is a subscore\'s exported key' do
        expect(questionnaire.fields.description_for_variable('tot_i')).to eq('Total Interpretation')
        expect(questionnaire.fields.description_for_variable('tot')).to eq('Total Score')
      end
      it 'returns flag descriptions' do
        expect(questionnaire.fields.description_for_variable('test_flagtest')).to \
          eq('it described (true - \'it true\', false - \'it false\')')
      end
      it 'returns textvar descriptions' do
        expect(questionnaire.fields.description_for_variable('test_textvartest')).to eq('tv description')
      end
    end
  end
end
