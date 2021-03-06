# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  describe Questionnaire do
    let(:key)           { 'test' }
    let(:definition)    { "title 'My Test'" }
    let(:questionnaire) { Quby::Questionnaires::DSL.build(key, definition) }

    describe 'licenses' do
      it 'defaults to being unknown' do
        expect(questionnaire.license).to eq(:unknown)
      end

      it 'can be set to be unknown' do
        questionnaire.license = :unknown
        expect(questionnaire.license).to eq(:unknown)
      end

      it 'can be set to be free' do
        questionnaire.license = :free
        expect(questionnaire.license).to eq(:free)
      end

      it 'can be set to be private' do
        questionnaire.license = :private
        expect(questionnaire.license).to eq(:private)
      end

      it 'can be set to be pay_per_completion' do
        questionnaire.license = :pay_per_completion
        expect(questionnaire.license).to eq(:pay_per_completion)
      end

      it 'cannot be set to something else' do
        expect { questionnaire.license = :something }.to raise_error(ArgumentError)
      end

      it 'can set licensor' do
        questionnaire.licensor = 'Acme INC'
        expect(questionnaire.licensor).to eq('Acme INC')
      end
    end

    describe 'sbg key' do
      it 'defaults to nil/empty array' do
        expect(questionnaire.sbg_key).to be_nil
      end
    end

    describe 'sbg_domains' do
      it 'defaults to an empty array' do
        expect(questionnaire.sbg_domains).to eq([])
      end
    end

    describe '#scores' do
      it 'should have empty scores' do
        expect(Questionnaire.new("test").scores).to eq([])
      end
    end

    describe '#score_calculations' do
      it 'has empty score_calculations' do
        expect(Questionnaire.new("test").score_calculations).to eq({})
      end
    end

    describe '#add_score_calculation' do
      let(:questionnaire) { Questionnaire.new("test") }

      it 'adds the score builder to the list of score builders' do
        builder = double("Quby::Score", key: "c")
        questionnaire.add_score_calculation builder
        expect(questionnaire.score_calculations['c']).to eq builder
      end

      it 'preserves order of added score builders' do
        questionnaire.add_score_calculation double("Quby::Score", key: "c")
        questionnaire.add_score_calculation double("Quby::Score", key: "a")
        questionnaire.add_score_calculation double("Quby::Score", key: "d")
        expect(questionnaire.score_calculations.keys).to eq %w(c a d)
      end

      it 'throws exception if there already is a score builder known for this key' do
        questionnaire.add_score_calculation double(key: "c")

        expect do
          questionnaire.add_score_calculation double(key: "c")
        end.to raise_error(Quby::Questionnaires::Entities::Questionnaire::InputKeyAlreadyDefined,
                           "Score key `c` already defined.")
      end
    end

    describe '#find_plottable' do
      it 'finds score builders' do
        score = double(key: 'a')
        questionnaire.add_score_calculation score
        expect(questionnaire.find_plottable('a')).to eq score
      end

      it 'finds questions by key with indifferent access' do
        question = double(key: 'a')
        questionnaire.question_hash['a'] = question
        expect(questionnaire.find_plottable(:a)).to eq question
      end
    end

    context 'key lists' do
      let(:questionnaire) do
        Quby::Questionnaires::DSL.build("test") do
          question :radio, type: :radio, depends_on: [:check] do
            title "Testvraag"
            option :rad1
            option :rad2
          end

          question :check, type: :check_box do
            title "Checkbox vraag"
            option :check1
            option :check2
          end

          question :int, type: :integer

          question :date, type: :date, components: [:year, :month]
        end
      end

      describe '#input_keys' do
        it 'should list all input keys' do
          expect(questionnaire.input_keys).to eq Set.new([:radio_rad1, :radio_rad2, :check1, :check2, :int,
                                                          :date_mm, :date_yyyy])
        end
      end

      describe '#answer_keys' do
        it 'should list all answer keys' do
          expect(questionnaire.answer_keys).to eq Set.new([:radio, :check1, :check2, :int,
                                                           :date_mm, :date_yyyy])
        end
      end
    end

    describe '#key_in_use?' do
      let(:definition)    { "" }
      let(:questionnaire) do
        Quby::Questionnaires::DSL.build("test") do
          title 'My Test'
          question :v_1, type: :string
          score :score_1, label: 'score 1', schema: [{key: :value, label: 'Score', export_key: :sc1}] do {value: 42} end
          variable :var_1
        end
      end

      it "should check if key is used by a question" do
        expect(questionnaire.key_in_use?(:v_1)).to be_truthy
      end
      it "should check if key is used by a score" do
        expect(questionnaire.key_in_use?(:score_1)).to be_truthy
      end
      it "should check if key is used by a variable" do
        expect(questionnaire.key_in_use?(:var_1)).to be_truthy
      end
    end

    describe '#to_codebook' do
      it "should be able to generate a codebook" do
        questionnaire = Quby::Questionnaires::DSL.build("test") do
          title 'My Test'
          question :v_1, type: :radio do
            option :a1, value: 0; option :a2, value: 1
          end
        end

        expect(questionnaire.to_codebook).to be
      end

      it "should not break off a codebook when encountering <" do
        questionnaire = Quby::Questionnaires::DSL.build("test2") do
          title 'My Test'
          question :v_1, type: :radio do
            title ' < 20'
            option :a1, value: 0
            option :a2, value: 1
          end
        end

        expect(questionnaire.to_codebook).to eq "My Test\nDate unknown\n\ntest2_1 radio \n\" < 20\"\n0\t\"\"\n1\t\"\"\n"
      end

      it 'interleaves subquestions between checkbox options, to match quby_proxy behavior' do
        questionnaire = Quby::Questionnaires::DSL.build("test") do
          title 'My Test'
          question(:v_1, type: :check_box) do
            option :v_1_a1, value: 0 do
              question :v_1_a1_1, type: :string
              question :v_1_a1_2, type: :string
            end
            inner_title 'make it complex'
            option :v_1_a2, value: 1 do
              question :v_1_a2_1, type: :string
            end
          end
        end

        expect(questionnaire.to_codebook).to eq("My Test\nDate unknown\n\ntest_1_a1 check_box\n1\tChecked\n0\tUnchecked\nempty\tUnchecked\n\ttest_1_a1_1 string \n\ttest_1_a1_2 string \n\ntest_1_a2 check_box\n1\tChecked\n0\tUnchecked\nempty\tUnchecked\n\ttest_1_a2_1 string \n")
      end

      describe 'with flags' do
        it 'contains flags' do
          questionnaire = Quby::Questionnaires::DSL.build("test") do
            title 'My Test'

            flag key: :depr,
                 description_true: 'Er is sprake van depressieklachten',
                 description_false: 'Er is geen sprake van depressieklachten',
                 trigger_on: false,
                 hides_questions: [:v_1]

            question :v_1, type: :string do
              title 'gehide door depr false'
            end
          end

          expect(questionnaire.to_codebook).to eq("My Test\nDate unknown\n\ntest_1 string \n\"gehide door depr false\"\n\ntest_depr flag\n 'true' - Er is sprake van depressieklachten\n 'false' - Er is geen sprake van depressieklachten\n '' (leeg) - Vlag niet ingesteld, informatie onbekend\n\n")
        end
      end

      describe 'with textvars' do
        it 'contains textvars' do
          questionnaire = Quby::Questionnaires::DSL.build("test") do
            title 'My Test'

            textvar key: :probleem_1, description: 'probleem 1', default: ''

            question :v_1, type: :string do
              title 'vraag'
            end
          end

          expect(questionnaire.to_codebook).to eq("My Test\nDate unknown\n\ntest_1 string \n\"vraag\"\n\ntest_probleem_1 Textvariabele\nprobleem 1\n")
        end
      end

      describe 'with textvar that depends on a flag' do
        it 'will have a depends_on_flag attribute' do
          questionnaire = Quby::Questionnaires::DSL.build("test") do
            title 'My Test'

            flag key: :testflag, description_true: 'Test', description_false: 'Test uit', shows_questions: [:v_1]
            textvar key: :probleem_1, description: 'probleem 1', default: '', depends_on_flag: :test_testflag

            question :v_1, type: :string do
              title 'vraag'
            end
          end

          expect(questionnaire.textvars[:test_probleem_1].depends_on_flag).to eq(:test_testflag)
        end
      end

      describe 'with textvar that depends on a nonexistent flag' do
        it 'will raise on creation' do
          expect do
            Quby::Questionnaires::DSL.build("test") do
              title 'My Test'

              flag key: :testflag, description_true: 'Test', description_false: 'Test uit', shows_questions: [:v_1]
              textvar key: :probleem_1, description: 'probleem 1', default: '', depends_on_flag: :nonexistent

              question :v_1, type: :string do
                title 'vraag'
              end
            end
          end.to raise_exception(ArgumentError,
                                 'Textvar \'test_probleem_1\' depends on nonexistent flag \'nonexistent\'')
        end
      end
    end

    describe '#add_chart' do
      let(:charts)        { double }
      let(:chart)         { double(key: 'tot', scores: [double("Score")]) }
      let(:questionnaire) { Questionnaire.new('test') }

      it 'adds charts' do
        allow(questionnaire).to receive(:charts).and_return(charts)
        expect(charts).to receive(:add).with(chart)
        questionnaire.add_chart(chart)
      end
    end

    describe '#questions_of_type' do
      let(:definition)    { "text 'text thing' \n question :v_1, type: :radio \n question :v_2, type: :string" }
      let(:questionnaire) { Quby::Questionnaires::DSL.build('questions_of_type_test', definition) }
      it 'returns questions of the given type' do
        expect(questionnaire.questions_of_type(:string).count).to eq 1
        expect(questionnaire.questions_of_type(:string).first.type).to eq :string
      end
    end

    describe '#leave_page_alert' do
      it 'returns a given string' do
        questionnaire = Questionnaire.new 'test'
        questionnaire.leave_page_alert = "ALERT"
        expect(questionnaire.leave_page_alert).to eq("ALERT")
      end

      it 'returns a default string' do
        questionnaire = Questionnaire.new 'test'
        expect(questionnaire.leave_page_alert).to eq("Als u de pagina verlaat worden uw antwoorden niet opgeslagen.")
      end

      it 'returns nil if leave page alerts are disabled' do
        allow(Quby::Settings).to receive(:enable_leave_page_alert).and_return(false)
        questionnaire = Questionnaire.new 'test'
        expect(questionnaire.leave_page_alert).to be_nil
      end
    end

    describe 'flags integration' do
      let(:definition)    do
        "
        flag key: :test, description_true: 'Test flag', description_false: 'Test flag uit', shows_questions: [:v_1]
        flag key: :test2, description_true: 'Test flag 2', description_false: 'Test flag 2 uit', hides_questions: [:v_2]
        "
      end

      it 'presents flags that were defined in the definition' do
        expect(questionnaire.flags).to eq({ 'test_test' => Quby::Questionnaires::Entities::Flag.new(
                                                 key: :test_test,
                                                 description_true: 'Test flag',
                                                 description_false: 'Test flag uit',
                                                 shows_questions: [:v_1],
                                                 hides_questions: [],
                                                 depends_on: []),
                                            'test_test2' => Quby::Questionnaires::Entities::Flag.new(
                                                key: :test_test2,
                                                description_true: 'Test flag 2',
                                                description_false: 'Test flag 2 uit',
                                                shows_questions: [],
                                                hides_questions: [:v_2],
                                                depends_on: []) })
      end
    end

    describe '#add_flag' do
      it 'checks if the key is not in use' do
        questionnaire.add_flag(key: :a, description_true: 'a', description_false: 'not a')
        expect do questionnaire.add_flag(key: :a,
                                         description_true: 'a',
                                         description_false: 'not a')
        end.to raise_error(ArgumentError, "Flag 'test_a' already defined")
      end

      it 'uses the flag key if the flag is internal' do
        questionnaire.add_flag(key: :a, description_true: 'a', description_false: 'not a', internal: true)
        expect(questionnaire.flags.keys).to eq(['a'])
      end

      it 'prepends the questionnaire key if the flag is not internal' do
        expect(questionnaire).to receive(:key).and_return('test')
        questionnaire.add_flag(key: :a, description_true: 'a', description_false: 'not a')
        expect(questionnaire.flags.keys).to eq(['test_a'])
      end
    end

    describe "#filter_flags" do
      it 'filters out flags that are not defined on the questionnaire' do
        questionnaire.add_flag key: :a, description_true: 'a', description_false: 'not a'
        expect(questionnaire.filter_flags({test_a: true, test_b: false, something: false})).to eq({test_a: true})
      end
    end

    describe "#answer_dsl_module" do
      it 'misses a lot of tests'

      context 'questionnaire with date' do
        let(:questionnaire) do
          Quby::Questionnaires::DSL.build("test") do
            question :v_1, type: :date, title: 'vraag'
          end
        end

        it 'strips values of date questions' do
          fake_answer = double(value: {}).extend questionnaire.answer_dsl_module
          fake_answer.v_1_yyyy = '2002 '
          expect(fake_answer.v_1_yyyy).to eq('2002')
        end

        it 'presents a nice formatted date' do
          fake_answer = double(value: {}).extend questionnaire.answer_dsl_module
          fake_answer.v_1_yyyy = '2002'
          fake_answer.v_1_mm = '03'
          fake_answer.v_1_dd = '14'
          expect(fake_answer.v_1).to eq('14-03-2002')
        end

        it 'shows only year when month is missing' do
          fake_answer = double(value: {}).extend questionnaire.answer_dsl_module
          fake_answer.v_1_yyyy = '2002'
          fake_answer.v_1_mm = ''
          fake_answer.v_1_dd = '14'
          expect(fake_answer.v_1).to eq('2002')
        end

        it 'shows only year and month when day is missing' do
          fake_answer = double(value: {}).extend questionnaire.answer_dsl_module
          fake_answer.v_1_yyyy = '2002'
          fake_answer.v_1_mm = '10'
          fake_answer.v_1_dd = ''
          expect(fake_answer.v_1).to eq('10-2002')
        end
      end
    end

    describe '#add_score_schema' do
      let(:options) { [{key: :value, export_key: :tot, label: 'Score'}] }
      it 'sets a score schema for a specific score' do
        questionnaire.add_score_schema :totaal, 'Totaal', options
        expect(questionnaire.score_schemas[:totaal]).to be_valid
      end

      describe 'when the score schema has errors' do
        let(:options) { [{}] } # misses attributes
        it 'passes on errors from the score schema onto the questionnaire' do
          questionnaire.add_score_schema :totaal, 'Totaal', options
          expected = ["Score schema 'totaal' subscore_schemas element #0 Key moet opgegeven zijn, Key is not a symbol\
, Label moet opgegeven zijn, Export key moet opgegeven zijn, Export key is not a symbol"]
          expect(questionnaire.errors.full_messages).to eq(expected)
        end
      end
    end

    describe '#add_outcome_table' do
      let(:questionnaire) do
        Quby::Questionnaires::DSL.build("test") do
          score(:key, label: 'score', schema: [{key: :value, label: 'Score', export_key: :key}]) { {value: 'oh1'} }
        end
      end

      it 'adds an outcome table model to the questionnaire\'s outcome_tables' do
        outcome_table_options = {key: :test_outcome_table, score_keys: [:key], subscore_keys: [:value]}
        questionnaire.add_outcome_table outcome_table_options
        table = questionnaire.outcome_tables.first
        expect(table.score_keys).to eq([:key])
        expect(table.subscore_keys).to eq([:value])
        expect(table.questionnaire).to eq(questionnaire)
      end
    end

    describe 'validations' do
      it 'has validations from all the questions' do
        questionnaire = Quby::Questionnaires::DSL.build("test") do
          question :v_1, type: :string, required: true
          question :v_2, type: :float, required: true do
            validates_minimum 5
            validates_maximum 10
          end
        end

        expect(questionnaire.validations.as_json).to match_array([
          {"fieldKey" => :v_1, "type" => :requires_answer, "explanation" => nil},
          {"fieldKey" => :v_2, "type" => :requires_answer, "explanation" => nil},
          # a float type automatically adds a validation that the data entered must be parseable as a float
          {"fieldKey" => :v_2, "type" => :valid_float, "explanation" => nil},
          {"fieldKey" => :v_2, "type" => :minimum, "subtype" => :number, "value" => 5, "explanation" => nil},
          {"fieldKey" => :v_2, "type" => :maximum, "subtype" => :number, "value" => 10, "explanation" => nil}
        ])
      end

      it 'adds a single validation for groups' do
        questionnaire = Quby::Questionnaires::DSL.build("test") do
          question :v_1, type: :string, question_group: "g1", group_minimum_answered: 1
          question :v_2, type: :string, question_group: "g1", group_minimum_answered: 1
        end

        expect(questionnaire.validations.as_json).to match_array([
          {"fieldKeys" => [:v_1, :v_2], "type" => :answer_group_minimum, "group" => "g1", "value" => 1, "explanation" => nil}
        ])
      end
    end

    describe 'visibility_rules' do
      it 'has rules for showing' do
        questionnaire = Quby::Questionnaires::DSL.build("test") do
          question :v_1, type: :radio do
            option :a1, value: 1, description: "x", shows_questions: [:v_2]
            option :a2, value: 2, description: "y", hides_questions: [:v_3]
          end

          question :v_2, type: :string, default_invisible: true
          question :v_3, type: :string
        end

        expect(questionnaire.visibility_rules.as_json).to match_array([
          {
            condition: {"fieldKey" => :v_1, "type" => :equal, "value" => :a1},
            action: {"type" => :show_question, "fieldKey" => :v_2}
          },
          {
            condition: {"fieldKey" => :v_1, "type" => :equal, "value" => :a2},
            action: {"type" => :hide_question, "fieldKey" => :v_3}
          },
          {
            condition: {"fieldKey" => :v_2, "type" => :always},
            action: {"type" => :hide_question, "fieldKey" => :v_2}
          }
        ])
      end
    end
  end
end
