# frozen_string_literal: true

def create_new_answer_for(questionnaire, flags: {}, textvars: {}, **answer_value)
  allow_any_instance_of(Quby::AnswersController).to receive(:verify_hmac).and_return(true)
  allow_any_instance_of(Quby::AnswersController).to receive(:verify_token).and_return(true)
  Quby.answers.create!(questionnaire.key, value: answer_value, flags: flags, textvars: textvars)
end

def visit_new_answer_for(questionnaire, mode = "paged", answer = nil, params = {})
  allow(Quby::Settings).to receive(:authorize_with_hmac).and_return(false)
  allow(Quby::Settings).to receive(:authorize_with_id_from_session).and_return(false)
  allow(Quby::Settings).to receive(:enable_leave_page_alert).and_return(false)

  answer ||= create_new_answer_for(questionnaire)
  visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?display_mode=#{mode}" \
        "#{'&' + params.to_query if params.present?}"
  answer
end
