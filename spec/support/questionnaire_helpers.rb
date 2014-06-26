def inject_questionnaire(key, definition)
  questionnaire = Quby::QuestionnaireDsl.build(key, definition, timestamp: Time.now)
  Quby.questionnaires.stub(:find).with(key).and_return(questionnaire)
  questionnaire
end
