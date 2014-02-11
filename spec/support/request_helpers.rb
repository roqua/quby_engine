include Capybara::DSL

def create_new_answer_for(questionnaire, answer_value = {})
  Quby::AnswersController.any_instance.stub(verify_hmac: true)
  Quby::AnswersController.any_instance.stub(verify_token: true)
  Quby::Questionnaire.any_instance.stub(leave_page_alert: nil)
  Quby::Answer.create!(questionnaire_key: questionnaire.key, value: answer_value)
end

def visit_new_answer_for(questionnaire, mode = "paged", answer = nil, params = {})
  Quby::Settings.stub(authorize_with_hmac: false)
  Quby::Settings.stub(authorize_with_id_from_session: false)

  answer ||= create_new_answer_for(questionnaire)
  visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?display_mode=#{mode}" +
        "#{'&' + params.to_query if params.present?}"
  answer
end
