# frozen_string_literal: true

require 'spec_helper'

describe Quby::Questionnaires::Deserializer do
  it 'sets title' do
    questionnaire = dsl { title 'Foo' }
    expect(questionnaire.title).to eq('Foo')
  end

  it 'sets description' do
    questionnaire = dsl { description 'This is a questionnaire description' }
    expect(questionnaire.description).to eq('This is a questionnaire description')
  end

  it 'sets outcome_description' do
    questionnaire = dsl { outcome_description 'Outcome description' }
    expect(questionnaire.outcome_description).to eq('Outcome description')
  end

  it 'set sbg_key' do
    questionnaire = dsl { sbg_key 'foo' }
    expect(questionnaire.sbg_key).to eq('foo')
  end

  it 'can request outcome regeneration' do
    timestamp = Time.local(2020, 5, 12, 4, 28, 19)
    questionnaire = dsl { outcome_regeneration_requested_at timestamp }
    expect(questionnaire.outcome_regeneration_requested_at).to eq(timestamp)
  end

  it 'can request answers to be deactivated' do
    timestamp = Time.local(2020, 5, 12, 4, 28, 19)
    questionnaire = dsl { deactivate_answers_requested_at timestamp }
    expect(questionnaire.deactivate_answers_requested_at).to eq(timestamp)
  end

  describe 'roqua keys' do
    it 'defaults to key' do
      questionnaire = dsl("example") {}
      expect(questionnaire.roqua_keys).to eq(["example"])
    end

    it 'sets roqua keys' do
      questionnaire = dsl { roqua_keys :alg_o, :alg_o2 }
      expect(questionnaire.roqua_keys).to eq(["alg_o", "alg_o2"])
    end
  end

  describe 'sbg_domain' do
    it 'sets sbg_domain' do
      questionnaire = dsl do
        sbg_domain '02', from: '2000-01-01', till: '2099-12-31', outcome: '01', sbg_key: 'OQ45-sd', primary: true
      end
      expect(questionnaire.sbg_domains).to eq(
        [
          {sbg_code: '02', from: '2000-01-01', till: '2099-12-31', outcome: '01', sbg_key: 'OQ45-sd', primary: true}
        ]
      )
    end

    it 'sets multiple sbg_domains with optional attributes' do
      questionnaire = dsl do
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
      questionnaire = dsl do
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
    expect { dsl { sbg_domain '02', foo: 'bar' } }.to raise_exception(ArgumentError, "missing keyword: :outcome")
  end

  it 'can be abortable' do
    questionnaire = dsl { }
    expect(questionnaire.abortable).to be_falsey

    questionnaire = dsl { abortable }
    expect(questionnaire.abortable).to be_truthy
  end

  it 'can allow hotkeys' do
    questionnaire = dsl { allow_hotkeys }
    expect(questionnaire.allow_hotkeys).to eq("all")
  end

  it 'can set license' do
    questionnaire = dsl { license :free }
    expect(questionnaire.license).to eq(:free)
    expect(questionnaire.licensor).to be_nil
  end

  it 'can set licensor' do
    questionnaire = dsl { license :free, licensor: 'FOO' }
    expect(questionnaire.licensor).to eq('FOO')
  end

  it 'can set language' do
    questionnaire = dsl { language :en }
    expect(questionnaire.language).to eq(:en)
  end

  it 'defaults to Dutch language' do
    questionnaire = dsl { }
    expect(questionnaire.language).to eq(:nl)
  end

  it 'can set respondent_types' do
    questionnaire = dsl { respondent_types :patient, :parent }
    expect(questionnaire.respondent_types).to eq([:patient, :parent])
  end

  it 'can set tags' do
    questionnaire = dsl { tags :diary }
    expect(questionnaire.tags.diary).to be_truthy
    expect(questionnaire.tags.another_tag).to be_falsey
  end

  it 'builds panels' do
    questionnaire = dsl { panel { title 'My Title' } }
    expect(questionnaire.panels.first.title).to eq('My Title')
  end

  it 'builds line charts' do
    questionnaire = dsl { line_chart(:tot) { title 'My Title'; range 0..40 } }
    expect(questionnaire.charts.find(:tot).title).to eq('My Title')
  end

  it 'builds bar charts' do
    questionnaire = dsl { bar_chart(:tot) { title 'My Title' } }
    expect(questionnaire.charts.find(:tot).title).to eq('My Title')
  end

  it 'builds radar charts' do
    questionnaire = dsl { radar_chart(:tot) { title 'My Title' } }
    expect(questionnaire.charts.find(:tot).title).to eq('My Title')
  end

  it 'sets a depends_on key correctly' do
    questionnaire = dsl do
      question :v_1, type: :check_box do
        option :v_1_a
      end
      question :v_2, type: :string, depends_on: [:v_1]
    end
    expect(questionnaire.question_hash[:v_2].depends_on).to eq [:v_1_a]
  end

  it 'sets the parent option key on subquestions correctly' do
    questionnaire = dsl do
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
      questionnaire = dsl do
        flag key: :test, description: 'test flag'
      end
      expect(questionnaire.flags[:test_test].description).to eq("test flag")
    end
  end

  describe '#add_lookup_tree' do
    it 'can add a lookup tree' do
      questionnaire = dsl do
        add_lookup_tree :interpretations,
          levels: ['score', 'interpretation'],
          tree: {
            0..24 => 'low',
            25..50 => 'high'
          }
      end

      expect(questionnaire.lookup_tables[:interpretations].lookup(score: 26)).to eq 'high'
    end
  end

  describe '#score_schema' do
    it 'calls #add_score_schema with the given arguments' do
      options = [{key: :value, export_key: :tot, label: 'Score'}]
      questionnaire = dsl do
        score :totaal, label: 'totaal' do
          {value: 100}
        end

        score_schema :totaal, 'Totaal', options
      end

      expect(questionnaire.score_schemas[:totaal].subscore_schemas[0].export_key).to eq(:tot)
    end
  end

  describe '#outcome_table' do
    it 'calls questionnaire.add_outcome_table with the given arguments' do
      questionnaire = dsl do
        outcome_table key: :default, score_keys: [:a], subscore_keys: [:b]
      end
      expect(questionnaire.outcome_tables[0].score_keys).to eq([:a])
      expect(questionnaire.outcome_tables[0].subscore_keys).to eq([:b])
    end
  end

  def dsl(key = "test", &block)
    source = Quby::Compiler::DSL.build(key, "", &block)
    json = Quby::Compiler::Outputs::QubyFrontendV1Serializer.new(source).to_json
    described_class.from_json(JSON.parse(json))
  end
end
