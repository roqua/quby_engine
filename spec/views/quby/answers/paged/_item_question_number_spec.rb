require 'spec_helper'
module Quby
  describe "quby/answers/paged/_item_question_number" do
    let(:question) do
      stub(key: :q1,
           description: "",
           title: "Titel!",
           left_label: nil,
           right_label: nil,
           html_id: "",
           type: :integer,
           as: :slider,
           validations: [{type: :minimum, value: 1},
                         {type: :maximum, value: 20}],
           input_data: {},
           show_values: :bulk,
           autocomplete: false,
           disabled: false,
           size: nil,
           unit: nil)
    end

    before { view.stub(marukufix: "HOI") }

    it 'renders a left and right label if both provided' do
      question.stub(left_label: "mijn left label")
      question.stub(right_label: "mijn right label")
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should include("mijn left label")
      rendered.should include("mijn right label")
    end

    it 'sets the right min and max attributes' do
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should include('min="1"')
      rendered.should include('max="20"')
    end

    it 'sets a floating step size for float questions' do
      question.stub(type: :float)
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should include("step=\"0.01\"")
    end

    it 'sets data: {show_values: true} show_values in [:paged, :all, true]' do
      question.stub(show_values: :paged)
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should include(%q~data-show-values="true"~)

      question.stub(show_values: :true)
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should include(%q~data-show-values="true"~)

      question.stub(show_values: :all)
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should include(%q~data-show-values="true"~)
    end

    it 'should not set data: {show_values: true} show_values in [:paged, :all, true]' do
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should_not include(%q~data-show-values="true"~)
    end

    it 'should pass on any input-data to the inputs data attributes' do
      question.stub(input_data: {foo: 'bar'})
      render partial: "quby/answers/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
      rendered.should include(%q~data-foo="bar"~)
    end
  end
end
