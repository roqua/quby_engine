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
        Questionnaire.new("test").scores.should eq([])
      end
    end

    describe '#score_calculations' do
      it 'has empty score_calculations' do
        Questionnaire.new("test").score_calculations.should eq({})
      end
    end

    describe '#add_score_calculation' do
      let(:questionnaire) { Questionnaire.new("test") }

      it 'adds the score builder to the list of score builders' do
        builder = double("Quby::Score", key: "c")
        questionnaire.add_score_calculation builder
        questionnaire.score_calculations['c'].should eq builder
      end

      it 'preserves order of added score builders' do
        questionnaire.add_score_calculation double("Quby::Score", key: "c")
        questionnaire.add_score_calculation double("Quby::Score", key: "a")
        questionnaire.add_score_calculation double("Quby::Score", key: "d")
        questionnaire.score_calculations.keys.should eq %w(c a d)
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
        questionnaire.find_plottable('a').should eq score
      end

      it 'finds questions by key with indifferent access' do
        question = double(key: 'a')
        questionnaire.question_hash['a'] = question
        questionnaire.find_plottable(:a).should eq question
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
          score :score_1
          variable :var_1
        end
      end

      it "should check if key is used by a question" do
        questionnaire.key_in_use?(:v_1).should be_truthy
      end
      it "should check if key is used by a score" do
        questionnaire.key_in_use?(:score_1).should be_truthy
      end
      it "should check if key is used by a variable" do
        questionnaire.key_in_use?(:var_1).should be_truthy
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

        questionnaire.to_codebook.should be
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

        questionnaire.to_codebook.should eq "My Test\nDate unknown\n\ntest2_1 radio \n\" < 20\"\n0\t\"\"\n1\t\"\"\n"
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

        questionnaire.to_codebook.should eq("My Test\nDate unknown\n\ntest_1_a1 check_box\n1\tChecked\n0\tUnchecked\nempty\tUnchecked\n\ttest_1_a1_1 string \n\ttest_1_a1_2 string \n\ntest_1_a2 check_box\n1\tChecked\n0\tUnchecked\nempty\tUnchecked\n\ttest_1_a2_1 string \n")
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

          questionnaire.to_codebook.should eq("My Test\nDate unknown\n\ntest_1 string \n\"gehide door depr false\"\n\ntest_depr flag\n 'true' - Er is sprake van depressieklachten\n 'false' - Er is geen sprake van depressieklachten\n '' (leeg) - Vlag niet ingesteld, informatie onbekend\n\n")
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

          questionnaire.to_codebook.should eq("My Test\nDate unknown\n\ntest_1 string \n\"vraag\"\n\ntest_probleem_1 Textvariabele\nprobleem 1\n")
        end
      end

      describe 'with textvar that depends on a flag' do
        it 'will have a depends_on_flag attribute', focus: true do
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
        questionnaire.stub(charts: charts)
        charts.should_receive(:add).with(chart)
        questionnaire.add_chart(chart)
      end
    end

    describe '#questions_of_type' do
      let(:definition)    { "text 'text thing' \n question :v_1, type: :radio \n question :v_2, type: :string" }
      let(:questionnaire) { Quby::Questionnaires::DSL.build('questions_of_type_test', definition) }
      it 'returns questions of the given type' do
        questionnaire.questions_of_type(:string).count.should eq 1
        questionnaire.questions_of_type(:string).first.type.should eq :string
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
        Quby::Settings.stub(enable_leave_page_alert: false)
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
                                                 hides_questions: []),
                                            'test_test2' => Quby::Questionnaires::Entities::Flag.new(
                                                key: :test_test2,
                                                description_true: 'Test flag 2',
                                                description_false: 'Test flag 2 uit',
                                                shows_questions: [],
                                                hides_questions: [:v_2]) })
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
        questionnaire.stub(key: 'test')
        questionnaire.add_flag(key: :a, description_true: 'a', description_false: 'not a', internal: true)
        expect(questionnaire.flags.keys).to eq(['a'])
      end

      it 'prepends the questionnaire key if the flag is not internal' do
        questionnaire.stub(key: 'test')
        questionnaire.add_flag(key: :a, description_true: 'a', description_false: 'not a')
        expect(questionnaire.flags.keys).to eq(['test_a'])
      end
    end

    describe '#validate_flag_depends_on' do
      let(:definition) do
        "
        flag key: :test, description_true: 'Test flag', description_false: 'Test flag uit'
        flag key: :test2, description_true: 'Test flag 2', description_false: 'Test flag 2 uit', depends_on: :test_test
        flag key: :test3, description_true: 'Test flag 3', description_false: 'Test flag 3 uit', depends_on: :nonexistent
        flag key: :test4, description_true: 'Test flag 4', description_false: 'Test flag 4 uit', depends_on: :nonexistent2
        "
      end
      it 'fails if a flag references a non existing flag key' do
        errors = <<~ERRORS.strip
          Flag test_test3 depends_on nonexistent flag 'nonexistent'
          Flag test_test4 depends_on nonexistent flag 'nonexistent2'
        ERRORS
        expect { questionnaire }.to raise_error(ArgumentError, errors)
      end

      describe 'if depends_on keys are correct' do
        let(:definition) do
          "
          flag key: :test, description_true: 'Test flag', description_false: 'Test flag uit'
          flag key: :test2, description_true: 'Test flag 2', description_false: 'Test flag 2 uit', depends_on: :test_test
          "
        end
        it 'succeeds' do
          expect { questionnaire }.to_not raise_error
        end
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
      end
    end
  end
end
