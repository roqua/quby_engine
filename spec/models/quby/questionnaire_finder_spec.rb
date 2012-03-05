require_relative "../../../app/models/quby/questionnaire_finder"

module Quby
  describe QuestionnaireFinder do
    describe '#find' do
      it 'finds one questionnaire' do
        questionnaire = stub
        questionnaire_class = stub
        questionnaire_class.stub(:new).with("test", "title 'foo'").and_return { questionnaire }
        File.stub(:read).with("/tmp/test.rb").and_return("title 'foo'")
        questionnaire_finder = QuestionnaireFinder.new("/tmp", questionnaire_class)
        questionnaire_finder.find("test").should == questionnaire
      end

      it 'raises RecordNotFound if it doesnt exist' do

      end
    end

    describe '#all' do
      it 'finds all questionnaires'
    end
  end
end
