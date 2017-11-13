require 'spec_helper'
module Quby
  describe "quby/v1/paged/_item_question_number" do
    let(:question_options) do {type: :integer,
                               title: "Titel!",
                               description: "",
                               as: :slider,
                               show_values: :bulk}
    end
    let(:question) do
      question = Questionnaires::Entities::Questions::IntegerQuestion.new :q1, question_options
      question.validations << {type: :minimum, value: 1, subtype: :number}
      question.validations << {type: :maximum, value: 20, subtype: :number}
      question
    end

    before { view.extend Quby::TextTransformation }

    subject(:render_partial) do
      render partial: "quby/v1/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
    end

    it 'renders a left and right label if both provided' do
      question.stub(labels: ["mijn left label", "mijn right label"])
      render_partial
      rendered.should include("mijn left label")
      rendered.should include("mijn right label")
    end

    it 'sets the right min and max attributes' do
      render_partial
      rendered.should include('min="1"')
      rendered.should include('max="20"')
    end

    it 'sets a floating step size for float questions' do
      question.stub(type: :float)
      render_partial
      rendered.should include("step=\"0.01\"")
    end

    it 'sets data: {show_values: true} when show_values in [:paged, :all, true]' do
      question.stub(show_values: :paged)
      render_partial
      rendered.should include(%q~data-show-values="true"~)

      question.stub(show_values: :true)
      render_partial
      rendered.should include(%q~data-show-values="true"~)

      question.stub(show_values: :all)
      render_partial
      rendered.should include(%q~data-show-values="true"~)
    end

    it 'should not set data: {show_values: true} when show_values in [:none]' do
      question.stub(show_values: :none)
      render_partial
      rendered.should_not include(%q~data-show-values="true"~)
    end

    it 'should pass on any input-data to the inputs data attributes' do
      question.stub(input_data: {foo: 'bar'})
      render_partial
      rendered.should include(%q~data-foo="bar"~)
    end

    it 'sets default position of the slider' do
      question_options[:default_position] = 42
      render_partial
      expect(rendered).to include(%q~data-default-position="42"~)
    end
  end
end
