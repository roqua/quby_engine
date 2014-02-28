require 'spec_helper'

module Quby
  describe Questionnaire do
    before do
      @temp_dir = Dir.mktmpdir
      Quby.questionnaires_path = @temp_dir
    end

    after do
      FileUtils.remove_entry_secure @temp_dir
    end

    let(:key)           { 'test' }
    let(:definition)    { "title 'My Test'" }
    let(:questionnaire) { Questionnaire.new(key, definition) }

    describe '#scores' do
      it 'should have empty scores' do
        Questionnaire.new("test").scores.should eq([])
      end
    end

    describe '#score_builders' do
      it 'has empty score_builders' do
        Questionnaire.new("test").score_builders.should eq({})
      end
    end

    describe '#push_score_builder' do
      let(:questionnaire) { Questionnaire.new("test") }

      it 'adds the score builder to the list of score builders' do
        builder = double("Quby::Score", key: "c")
        questionnaire.push_score_builder builder
        questionnaire.score_builders['c'].should eq builder
      end

      it 'preserves order of added score builders' do
        questionnaire.push_score_builder double("Quby::Score", key: "c")
        questionnaire.push_score_builder double("Quby::Score", key: "a")
        questionnaire.push_score_builder double("Quby::Score", key: "d")
        questionnaire.score_builders.keys.should eq %w(c a d)
      end

      it 'overwrites the score builder if there already is a score builder known for this key' do
        questionnaire.push_score_builder double(key: "c")

        new_builder = double(key: "c")
        questionnaire.push_score_builder new_builder
        questionnaire.score_builders.shift.last.should eq new_builder
      end
    end

    describe '#find_plottable' do
      it 'finds score builders' do
        score = double(key: 'a')
        questionnaire.push_score_builder score
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
        questionnaire = Quby::Questionnaire.new("test", <<-END)
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
        END
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
      let(:definition)    { "title 'My Test' \n question :v_1 \n score :score_1 \n variable :var_1" }
      let(:questionnaire) { Questionnaire.new("test", definition) }

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
        definition    = "title 'My Test' \n question(:v_1, type: :radio) { option :a1, value: 0; option :a2, value: 1}"
        questionnaire = Questionnaire.new("test", definition)
        questionnaire.to_codebook.should be
      end

      it "should not break off a codebook when encountering <" do
        definition    = """
          title 'My Test'
          question(:v_1, type: :radio, title: ' < 20') { option :a1, value: 0; option :a2, value: 1}
        """
        questionnaire = Questionnaire.new("test2", definition)
        questionnaire.to_codebook.should eq "My Test\nDate unknown\n\ntest2_1 radio \n\" < 20\"\n0\t\"\"\n1\t\"\"\n"
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
      let(:questionnaire) { Questionnaire.new(:questions_of_type_test, definition) }
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
        Settings.stub(enable_leave_page_alert: false)
        questionnaire = Questionnaire.new 'test'
        expect(questionnaire.leave_page_alert).to be_nil
      end
    end
  end
end
