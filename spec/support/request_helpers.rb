def visit_new_answer_for(questionnaire, mode = "paged")
  Quby::AnswersController.any_instance.stub(:verify_hmac => true)
  Quby::AnswersController.any_instance.stub(:verify_token => true)
  Quby::Questionnaire.any_instance.stub(:leave_page_alert => nil)

  answer = Quby::Answer.create(:questionnaire_key => questionnaire.key)
  visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?display_mode=#{mode}"
  answer
end
