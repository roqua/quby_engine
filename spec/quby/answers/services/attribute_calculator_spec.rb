require 'spec_helper'

describe Quby::Answers::Services::AttributeCalculator do
  it 'marks questions hidden by a checkbox option as hidden' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v_1, type: :check_box, title: 'Q1' do
        option :v_1_a1, value: 1, description: "Hides v_2", hides_questions: [:v_2]
        inner_title "Foo"
      end

      question :v_2, type: :string, title: "Q2"
    END

    calculator = described_class.new(questionnaire, make_answer("v_1_a1" => 1, "v_2" => "something"))
    calculator.hidden.should == [:v_2]
  end

  it 'marks questions shown by a checkbox option as shown' do
    questionnaire = inject_questionnaire("test", <<-END)
      question :v_1, type: :check_box, title: 'Q1' do
        option :v_1_a1, value: 1, description: "Shows v_2", shows_questions: [:v_2]
        inner_title "Foo"
      end

      question :v_2, type: :string, title: "Q2", default_invisible: true
    END

    calculator = described_class.new(questionnaire, make_answer("v_1_a1" => 1, "v_2" => "something"))
    calculator.shown.should  eq([:v_2])
    calculator.hidden.should eq([])
  end

  it 'marks questions hidden by a flag as hidden' do
    questionnaire = inject_questionnaire("test", <<-END)
      flag key: 'test1', description_true: 'a', description_false: 'af', hides_questions: [:v_1]
      question :v_1, type: :string, title: 'Q1'
      question :v_2, type: :string, title: "Q2"
    END

    calculator = described_class.new(questionnaire, make_answer("v_1_a1" => 1, "v_2" => "something",
                                                                flags: {test_test1: true}))
    calculator.hidden.should eq([:v_1])
  end

  it 'marks questions hidden by a flag but shown by an answer as shown' do
    questionnaire = inject_questionnaire("test", <<-END)
      flag key: 'test1', description_true: 'a', description_false: 'af', hides_questions: [:v_2]
      question :v_1, type: :radio, title: 'Q1' do
        option :a1, shows_questions: [:v_2]
      end
      question :v_2, type: :string, title: "Q2"
    END

    calculator = described_class.new(questionnaire, make_answer("v_1" => 'a1', "v_2" => "something",
                                                                flags: {test_test1: true}))
    calculator.hidden.should eq([])
    calculator.shown.should eq([:v_2])
  end

  it 'marks questions shown by a flag but hidden by an answer as shown' do
    questionnaire = inject_questionnaire("test", <<-END)
      flag key: 'test1', description_true: 'a', description_false: 'af', shows_questions: [:v_2]
      question :v_1, type: :radio, title: 'Q1' do
        option :a1, hides_questions: [:v_2]
      end
      question :v_2, type: :string, title: "Q2"
    END

    calculator = described_class.new(questionnaire, make_answer("v_1" => 'a1', "v_2" => "something",
                                                                flags: {test_test1: true}))
    calculator.hidden.should eq([])
    calculator.shown.should eq([:v_2])
  end

  it 'marks questions shown by a flag as shown' do
    questionnaire = inject_questionnaire("test", <<-END)
    flag key: 'test1', description_true: 'a', description_false: 'af', shows_questions: [:v_1]
      question :v_1, type: :string, title: 'Q1', default_invisible: true
      question :v_2, type: :string, title: "Q2"
    END

    calculator = described_class.new(questionnaire, make_answer("v_1_a1" => 1, "v_2" => "something",
                                                                flags: {test_test1: true}))
    calculator.shown.should  eq([:v_1])
    calculator.hidden.should eq([])
  end

  def make_answer(value = {}, flags: {})
    Quby::Answers::Entities::Answer.new(questionnaire_key: 'test', value: value, flags: flags).tap(&:enhance_by_dsl)
  end
end
