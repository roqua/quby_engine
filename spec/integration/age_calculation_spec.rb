require 'spec_helper'
module Quby
  describe 'Age in scores' do
    let!(:questionnaire) { Quby.questionnaire_finder.find('scared') }
    let(:answer) { Quby.answer_repo.create('scared', patient: {"birthyear" => 2000, "gender" => :male}) }
    let(:updates_answers) { UpdatesAnswers.new answer }

    it 'can access age in a real score calculation' do
      answer.stub(:completed?).and_return true
      updates_answers.update
      answer.scores.should == {"tot" => {"label" => "Totaalscore",
                                         "value" => 10,
                                         "interpretation" => "Laag",
                                         "score" => true}}
    end
  end
end
