def inject_questionnaire(key, definition)
  questionnaire = Quby::Questionnaire.new(key, definition, Time.now)
  Quby.questionnaires.stub(:find).with(key).and_return(questionnaire)
  questionnaire
end
