require 'spec_helper'
module Quby
  describe "quby/answers/bulk/_item_question_number" do
    let(:question) do
      stub(:key => :q1,
           :description => "",
           :title => "Titel!",
           :left_label => nil,
           :right_label => nil,
           :html_id => "",
           :type => :integer,
           :as => :slider,
           :validations => [{:type => :minimum, :value => 1},
                            {:type => :maximum, :value => 20}],
           :autocomplete => false,
           :disabled => false,
           :size => nil,
           :unit => nil)
    end

    before { view.stub(:marukufix=> "HOI") }

    it 'renders a left and right label if both provided' do
      question.stub(:left_label => "mijn left label")
      question.stub(:right_label => "mijn right label")
      render :partial => "quby/answers/bulk/item_question_number", :locals => {question: question, subquestion: false, disabled: false}
      rendered.should include("mijn left label")
      rendered.should include("mijn right label")
    end

    it 'sets a floating step size for float questions' do
      question.stub(type: :float)
      render :partial => "quby/answers/bulk/item_question_number", :locals => {question: question, subquestion: false, disabled: false}
      rendered.should include("step=\"0.01\"")
    end
  end
end