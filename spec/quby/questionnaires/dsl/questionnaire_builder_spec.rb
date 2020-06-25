# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::DSL
  describe QuestionnaireBuilder do
    let(:questionnaire) { Quby::Questionnaires::Entities::Questionnaire.new("example") }
    let(:builder) { QuestionnaireBuilder.new(questionnaire) }

    it 'sets title' do
      dsl { title 'Foo' }
      expect(questionnaire.title).to eq('Foo')
    end

    it 'sets description' do
      dsl { description 'This is a questionnaire description' }
      expect(questionnaire.description).to eq('This is a questionnaire description')
    end

    it 'sets outcome_description' do
      dsl { outcome_description 'Outcome description' }
      expect(questionnaire.outcome_description).to eq('Outcome description')
    end

    it 'can disable checking key clashes' do
      expect(questionnaire.check_key_clashes).to eq(true)
      dsl { do_not_check_key_clashes }
      expect(questionnaire.check_key_clashes).to eq(false)
    end

    it 'set sbg_key' do
      dsl { sbg_key 'foo' }
      expect(questionnaire.sbg_key).to eq('foo')
    end

    it 'can request outcome regeneration' do
      timestamp = Time.local(2020, 5, 12, 4, 28, 19)
      dsl { outcome_regeneration_requested_at timestamp }
      expect(questionnaire.outcome_regeneration_requested_at).to eq(timestamp)
    end

    it 'can request answers to be deactivated' do
      timestamp = Time.local(2020, 5, 12, 4, 28, 19)
      dsl { deactivate_answers_requested_at timestamp }
      expect(questionnaire.deactivate_answers_requested_at).to eq(timestamp)
    end

    describe 'roqua keys' do
      it 'defaults to key' do
        dsl {}
        expect(questionnaire.roqua_keys).to eq(["example"])
      end

      it 'sets roqua keys' do
        dsl { roqua_keys :alg_o, :alg_o2 }
        expect(questionnaire.roqua_keys).to eq([:alg_o, :alg_o2])
      end
    end

    describe 'sbg_domain' do
      it 'sets sbg_domain' do
        dsl do
          sbg_domain '02', from: '2000-01-01', till: '2099-12-31', outcome: '01', sbg_key: 'OQ45-sd', primary: true
        end
        expect(questionnaire.sbg_domains).to eq(
          [
            {sbg_code: '02', from: '2000-01-01', till: '2099-12-31', outcome: '01', sbg_key: 'OQ45-sd', primary: true}
          ]
        )
      end

      it 'sets multiple sbg_domains with optional attributes' do
        dsl do
          sbg_domain '02', outcome: '01', sbg_key: 'OQ45-sd', primary: false
          sbg_domain '03', outcome: '02', from: '2000-01-01', till: '2099-12-31'
        end
        expect(questionnaire.sbg_domains).to eq(
          [
            {sbg_code: '02', from: nil, till: nil, outcome: '01', sbg_key: 'OQ45-sd', primary: false},
            {sbg_code: '03', from: '2000-01-01', till: '2099-12-31', outcome: '02', sbg_key: nil, primary: false}
          ]
        )
      end

      it 'defaults the sbg_key to the sbg_key of the questionnaire' do
        dsl do
          sbg_key 'example'
          sbg_domain '03', from: '2000-01-01', till: '2099-12-31', outcome: '01'
        end
        expect(questionnaire.sbg_domains).to eq(
          [
            {sbg_code: '03', from: '2000-01-01', till: '2099-12-31', outcome: '01', sbg_key: 'example', primary: false}
          ]
        )
      end
    end

    it 'does not accept invalid sbg_domains options' do
      expect { dsl { sbg_domain '02', foo: 'bar' } }.to raise_exception(ArgumentError, "missing keyword: outcome")
    end

    it 'can be abortable' do
      expect(questionnaire.abortable).to be_falsey
      dsl { abortable }
      expect(questionnaire.abortable).to be_truthy
    end

    it 'can allow hotkeys' do
      dsl { allow_hotkeys }
      expect(questionnaire.allow_hotkeys).to eq("all")
    end

    it 'can set license' do
      dsl { license :free }
      expect(questionnaire.license).to eq(:free)
      expect(questionnaire.licensor).to be_nil
    end

    it 'can set licensor' do
      dsl { license :free, licensor: 'FOO' }
      expect(questionnaire.licensor).to eq('FOO')
    end

    it 'can set language' do
      dsl { language :en }
      expect(questionnaire.language).to eq(:en)
    end

    it 'defaults to Dutch language' do
      dsl { }
      expect(questionnaire.language).to eq(:nl)
    end

    it 'can set respondent_types' do
      dsl { respondent_types :patient, :parent }
      expect(questionnaire.respondent_types).to eq([:patient, :parent])
    end

    it 'can set tags' do
      dsl { tags :diary }
      expect(questionnaire.tags.diary).to be_truthy
      expect(questionnaire.tags.another_tag).to be_falsey
    end

    it 'builds panels' do
      dsl { panel { title 'My Title' } }
      expect(questionnaire.panels.first.title).to eq('My Title')
    end

    it 'builds line charts' do
      dsl { line_chart(:tot) { title 'My Title'; range 0..40 } }
      expect(questionnaire.charts.find(:tot).title).to eq('My Title')
    end

    it 'builds bar charts' do
      dsl { bar_chart(:tot) { title 'My Title' } }
      expect(questionnaire.charts.find(:tot).title).to eq('My Title')
    end

    it 'builds radar charts' do
      dsl { radar_chart(:tot) { title 'My Title' } }
      expect(questionnaire.charts.find(:tot).title).to eq('My Title')
    end

    it 'checks for duplicate question keys' do
      expect do
        dsl do
          question :v_1, type: :string
          question :v_1, type: :string
        end
      end.to raise_exception(RuntimeError, "example:v_1: A question or option with input key v_1 is already defined.")
    end

    it 'checks for subquestion clashing with parent question' do
      skip
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
      end.to raise_exception(RuntimeError, "example:v_1:a1: A question or option with input key v_1_a1 is already defined.")
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
      end.to raise_exception(RuntimeError, "example:v_1:a_a1: A question or option with input key v_1_a_a1 is already defined.")
    end

    it 'checks for duplicates in past date input keys' do
      expect do
        dsl do
          question :v_1_a, type: :date do
            option :a1
          end

          question :v_1_yyyy, type: :text
        end
      end.to raise_exception(NoMethodError, /undefined method `option'/)
    end

    it 'checks for duplicates when creating date input keys' do
      expect do
        dsl do
          question :v_1_yyyy, type: :text

          question :v_1_a, type: :date do
            option :a1
          end
        end
      end.to raise_exception(KeyError, "key not found: \"text\"")
    end

    it 'checks for checkbox option keys clashing with question keys' do
      expect do
        dsl do
          question :v_1, type: :string
          question :v_2, type: :check_box do
            option :v_1
          end
        end
      end.to raise_exception(RuntimeError, "example:v_2:v_1: A question or option with input key v_1 is already defined.")
    end

    it 'checks for checkbox option keys clashing with their own question key' do
      expect do
        dsl do
          question :v_1, type: :check_box do
            option :v_2
            option :v_1
          end
        end
      end.to raise_exception(RuntimeError, "example:v_1:v_1: A question or option with input key v_1 is already defined.")
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
      end.to raise_exception(RuntimeError, "example:v_2:v_1_a1: A question or option with input key v_1_a1 is already defined.")
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
      end.to raise_exception(Quby::Questionnaires::Entities::Questionnaire::UnknownInputKey, "Question v_1 depends_on contains an error: Unknown input key unknown")
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
      expect(questionnaire.question_hash[:v_2].parent_option_key).to eq(:v_1a)
    end

    describe 'flag' do
      before do
        allow_any_instance_of(Quby::Questionnaires::Entities::Questionnaire).to receive(:add_flag)
      end

      it 'defines flags' do
        dsl do
          flag key: :test, description: 'test flag'
        end
        expect(questionnaire).to have_received(:add_flag).with(key: :test, description: 'test flag')
      end
    end

    describe '#question' do
      it 'does not overwrite the @default_question_options' do
        dsl do
          default_question_options required: false, type: :checkbox
          question :v_1, type: :string, required: true
        end
        expect(builder.default_question_options[:required]).to eq false
      end
    end

    describe '#custom_method' do
      context 'valid definition' do
        before do
          dsl do
            custom_method :zzl_question do |question_key, question_title|
              question question_key, type: :scale do
                title question_title
                option :a1, value: 1
                option :a2, value: 2
              end
            end
          end
        end

        it 'can build a question with options' do
          dsl do
            panel do
              zzl_question :v_1, 'zzl title'
            end
          end
          expect(questionnaire.question_hash[:v_1].title).to eq 'zzl title'
          expect(questionnaire.question_hash[:v_1].type).to eq :scale
          expect(questionnaire.question_hash[:v_1].options[0].key).to eq :a1
        end

        it 'can be used within a table' do
          dsl do
            panel do
              table columns: 4 do
                zzl_question :v_1, 'zzl title'
              end
            end
          end
          expect(questionnaire.question_hash[:v_1].title).to eq 'zzl title'
          expect(questionnaire.question_hash[:v_1].type).to eq :scale
          expect(questionnaire.question_hash[:v_1].options[0].key).to eq :a1
        end
      end

      it 'fails when specifying an existing method' do
        expect do
          dsl do
            custom_method :question do |question_key, question_title|
              question question_key, type: :string, title: question_title
            end
            panel do
              zzl_question :v_1, 'zzl title'
            end
          end
        end.to raise_exception(RuntimeError, "Custom method trying to override existing method")
      end

      it 'fails when specifying a a method twice' do
        expect do
          dsl do
            custom_method :zzl_question do |question_key, question_title|
              question question_key, type: :string, title: question_title
            end
            custom_method :zzl_question do |question_key, question_title|
              question question_key, type: :string, title: question_title
            end
            panel do
              zzl_question :v_1, 'zzl title'
            end
          end
        end.to raise_exception(RuntimeError, "Custom method trying to override existing method")
      end
    end

    describe '#score' do
      it 'requires scores to have a label' do
        dsl do
          score :totaal do
            {value: 100}
          end
        end

        expect(questionnaire.errors.full_messages).to eq(["Score totaal misses label in score call"])
      end
    end

    describe '#score_schema' do
      let(:subschema_options) { [{key: :value, export_key: :tot, label: 'Score'}] }
      let(:set_dsl) do
        options = subschema_options
        dsl do
          score :totaal, label: 'totaal' do
            {value: 100}
          end

          score_schema :totaal, 'Totaal', options
        end
      end

      it 'calls #add_score_schema with the given arguments' do
        expect(questionnaire).to receive(:add_score_schema).with :totaal, 'Totaal', subschema_options
        set_dsl
      end
    end

    describe '#outcome_table' do
      it 'calls questionnaire.add_outcome_table with the given arguments' do
        expect(questionnaire).to receive(:add_outcome_table).with(score_keys: [:a], subscore_keys: [:b])
        dsl do
          outcome_table score_keys: [:a], subscore_keys: [:b]
        end
      end
    end

    describe '#video' do
      it 'passes arguments to a video tag call, and puts the result in a text item' do
        expect_any_instance_of(PanelBuilder).to receive(:video_tag).with('https://example.com/video.mp4', looping: true).and_return 'foo'

        dsl do
          panel do
            video 'https://example.com/video.mp4', looping: true
          end
        end
        expect(questionnaire.panels.first.items.first.raw_content).to eq('foo')
      end

    end

    def dsl(&block)
      builder.instance_eval(&block)
    end
  end
end
