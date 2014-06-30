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

      it 'overwrites the score builder if there already is a score builder known for this key' do
        questionnaire.add_score_calculation double(key: "c")

        new_builder = double(key: "c")
        questionnaire.add_score_calculation new_builder
        questionnaire.score_calculations.shift.last.should eq new_builder
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

          question :date, type: :date
        end
      end

      describe '#input_keys' do
        it 'should list all input keys' do
          expect(questionnaire.input_keys).to eq [:radio_rad1, :radio_rad2, :check1, :check2, :int,
                                                  :date_dd, :date_mm, :date_yyyy]
        end
      end

      describe '#answer_keys' do
        it 'should list all answer keys' do
          expect(questionnaire.answer_keys).to eq [:radio, :check1, :check2, :int, :date_dd,
                                                   :date_mm, :date_yyyy]
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
        questionnaire.key_in_use?(:v_1).should be_true
      end
      it "should check if key is used by a score" do
        questionnaire.key_in_use?(:score_1).should be_true
      end
      it "should check if key is used by a variable" do
        questionnaire.key_in_use?(:var_1).should be_true
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

        # rubocop:disable LineLength
        questionnaire.to_codebook.should eq("My Test\nDate unknown\n\ntest_1_a1 check_box\n1\tChecked\n0\tUnchecked\nempty\tUnchecked\n\ttest_1_a1_1 string \n\ttest_1_a1_2 string \n\ntest_1_a2 check_box\n1\tChecked\n0\tUnchecked\nempty\tUnchecked\n\ttest_1_a2_1 string \n")
        # rubocop:enable LineLength
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
      let(:questionnaire) { Quby::Questionnaires::DSL.build(:questions_of_type_test, definition) }
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
  end
end
