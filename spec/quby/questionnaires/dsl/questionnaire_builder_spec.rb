require 'spec_helper'

module Quby::Questionnaires::DSL
  describe QuestionnaireBuilder do
    let(:questionnaire) { Quby::Questionnaires::Entities::Questionnaire.new("example") }
    let(:builder) { QuestionnaireBuilder.new(questionnaire) }

    it 'sets title' do
      dsl { title 'Foo' }
      questionnaire.title.should == 'Foo'
    end

    it 'sets description' do
      dsl { description 'This is a questionnaire description' }
      questionnaire.description.should == 'This is a questionnaire description'
    end

    it 'sets outcome_description' do
      dsl { outcome_description 'Outcome description' }
      questionnaire.outcome_description.should == 'Outcome description'
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

    it 'can be abortable' do
      questionnaire.abortable.should be_falsey
      dsl { abortable }
      questionnaire.abortable.should be_truthy
    end

    it 'can allow hotkeys' do
      dsl { allow_hotkeys }
      questionnaire.allow_hotkeys.should == "all"
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
      questionnaire.panels.first.title.should == 'My Title'
    end

    it 'builds line charts' do
      dsl { line_chart(:tot) { title 'My Title'; range 0..40 } }
      questionnaire.charts.find(:tot).title.should == 'My Title'
    end

    it 'builds bar charts' do
      dsl { bar_chart(:tot) { title 'My Title' } }
      questionnaire.charts.find(:tot).title.should == 'My Title'
    end

    it 'builds radar charts' do
      dsl { radar_chart(:tot) { title 'My Title' } }
      questionnaire.charts.find(:tot).title.should == 'My Title'
    end

    it 'checks for duplicate question keys' do
      expect do
        dsl do
          question :v_1, type: :string
          question :v_1, type: :string
        end
      end.to raise_exception
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
      end.to raise_exception
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
      end.to raise_exception
    end

    it 'checks for duplicates in past date input keys' do
      expect do
        dsl do
          question :v_1_a, type: :date do
            option :a1
          end

          question :v_1_yyyy, type: :text
        end
      end.to raise_exception
    end

    it 'checks for duplicates when creating date input keys' do
      expect do
        dsl do
          question :v_1_yyyy, type: :text

          question :v_1_a, type: :date do
            option :a1
          end
        end
      end.to raise_exception
    end

    it 'checks for checkbox option keys clashing with question keys' do
      expect do
        dsl do
          question :v_1, type: :string
          question :v_2, type: :check_box do
            option :v_1
          end
        end
      end.to raise_exception
    end

    it 'checks for checkbox option keys clashing with their own question key' do
      expect do
        dsl do
          question :v_1, type: :check_box do
            option :v_2
            option :v_1
          end
        end
      end.to raise_exception
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
      end.to raise_exception
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
      end.to raise_exception
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
      questionnaire.question_hash[:v_2].parent_option_key.should == :v_1a
    end

    describe 'flag' do
      before do
        Quby::Questionnaires::Entities::Questionnaire.any_instance.stub(:add_flag)
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
        end.to raise_exception
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
        end.to raise_exception
      end
    end

    def dsl(&block)
      builder.instance_eval(&block)
    end
  end
end
