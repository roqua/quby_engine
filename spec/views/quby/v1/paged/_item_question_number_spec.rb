require 'spec_helper'
module Quby
  describe "quby/v1/paged/_item_question_number", type: :view do
    let(:question_options) do {type: :integer,
                               title: "Titel!",
                               description: "",
                               as: :slider,
                               minimum: 1,
                               maximum: 20,
                               show_values: :bulk}
    end
    let(:question) do
      Questionnaires::Entities::Questions::IntegerQuestion.new :q1, question_options
    end

    before { allow(view).to receive(:marukufix).and_return("HOI") }

    subject(:render_partial) do
      render partial: "quby/v1/paged/item_question_number",
             locals: {question: question, subquestion: false, disabled: false}
    end

    it 'renders a left and right label if both provided' do
      allow(question).to receive(:labels).and_return(["mijn left label", "mijn right label"])
      render_partial
      expect(rendered).to include("mijn left label")
      expect(rendered).to include("mijn right label")
    end

    it 'sets the right min and max attributes' do
      render_partial
      expect(rendered).to include('min="1"')
      expect(rendered).to include('max="20"')
    end

    it 'sets a floating step size for float questions' do
      allow(question).to receive(:type).and_return(:float)
      render_partial
      expect(rendered).to include("step=\"0.01\"")
    end

    it 'sets data: {show_values: true} when show_values in [:paged, :all, true]' do
      allow(question).to receive(:show_values).and_return(:paged)
      render_partial
      expect(rendered).to include(%q~data-show-values="true"~)

      allow(question).to receive(:show_values).and_return(true)
      render_partial
      expect(rendered).to include(%q~data-show-values="true"~)

      allow(question).to receive(:show_values).and_return(:all)
      render_partial
      expect(rendered).to include(%q~data-show-values="true"~)
    end

    it 'should not set data: {show_values: true} when show_values in [:none]' do
      allow(question).to receive(:show_values).and_return(:none)
      render_partial
      expect(rendered).to_not include(%q~data-show-values="true"~)
    end

    it 'should pass on any input-data to the inputs data attributes' do
      allow(question).to receive(:input_data).and_return({foo: 'bar'})
      render_partial
      expect(rendered).to include(%q~data-foo="bar"~)
    end

    it 'sets default position of the slider' do
      question_options[:default_position] = 42
      render_partial
      expect(rendered).to include(%q~data-default-position="42"~)
    end
  end
end
