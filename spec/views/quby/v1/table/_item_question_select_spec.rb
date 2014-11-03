require 'spec_helper'
module Quby
  describe "quby/v1/table/item_question_select" do
    let(:question) do
      double(key: :v_1,
             description: "",
             title: "Titel!",
             labels: [],
             html_id: "",
             type: :select,
             options: [double(:item_option,
                              key: :a1, description: 'option1', placeholder: false, hidden: true, view_id: '#a1'),
                       double(:item_option,
                              key: :a2, description: 'option2', placeholder: false, hidden: false, view_id: '#a2')],
             input_data: {},
             show_values: :bulk,
             autocomplete: false,
             disabled: false,
             size: nil,
             unit: nil,
             presentation: :vertical,
             row_span: nil,
             extra_data: nil,
             question_group: nil
      )
    end

    it 'does not render options that have hidden: true' do
      @answer = double(:answer, v_1: 'a2')
      render partial: "quby/v1/table/item_question_select",
             locals: {question: question, subquestion: false, disabled: false, os_cycle: 'a',
                      table: double(:table, columns: 2), validations: nil}

      expect(rendered).to_not include("option1")
    end

    it 'does render options that have hidden: true that are checked' do
      @answer = double(:answer, v_1: 'a1')
      render partial: "quby/v1/table/item_question_select",
             locals: {question: question, subquestion: false, disabled: false, os_cycle: 'a',
                      table: double(:table, columns: 2), validations: nil}

      expect(rendered).to include("option1")
    end
  end
end
