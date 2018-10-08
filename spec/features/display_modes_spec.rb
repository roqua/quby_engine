# frozen_string_literal: true

require 'spec_helper'

feature 'preview questionnaires in all modes', screenshots: true do
  REPO_PATH = "/Users/arnold/src/questionnaires/definitions"

  before(:all) do
    Rails.application.config.action_dispatch.show_exceptions = true
    Quby.questionnaire_repo = Quby::Questionnaires::Repos::DiskRepo.new(REPO_PATH)
  end

  before do
    Quby.questionnaire_repo = Quby::Questionnaires::Repos::DiskRepo.new(REPO_PATH)

    # Don't verify HMACs or tokens
    Quby::AnswersController.any_instance.stub(verify_hmac: true)
    Quby::AnswersController.any_instance.stub(verify_token: true)
    Quby::AnswersController.any_instance.stub(verify_answer_id_against_session: true)

    # Don't show warning when leaving page
    # Questionnaire.any_instance.stub(leave_page_alert: nil)
  end

  after(:all) do
    Rails.application.config.action_dispatch.show_exceptions = false
  end

  Quby.questionnaire_repo = Quby::Questionnaires::Repos::DiskRepo.new(REPO_PATH)
  Quby.questionnaires.all.each do |questionnaire|
    context "#{questionnaire.key}" do
      let(:answer) { Quby.answers.create!(questionnaire.key, token: "abcd") }

      scenario "screenshots #{questionnaire.key} in paged view", js: true, skip: true do
        visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?display_mode=paged"

        script = <<-END
          (function() {
            $(function() {
              $(".panel").show();
            });
          }).call(this);
        END

        page.driver.execute_script(script)

        screenshot "#{questionnaire.key}_paged"
      end

      scenario "screenshots #{questionnaire.key} in bulk view", js: true, skip: true do
        visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?display_mode=bulk"
        screenshot "#{questionnaire.key}_bulk"
      end

      scenario "screenshots #{questionnaire.key} in single_page view", js: true do
        visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?display_mode=single_page"

        script = <<-END
          (function() {
            $(function() {
              $(".panel").show();
            });
          }).call(this);
        END

        page.driver.execute_script(script)

        screenshot "#{questionnaire.key}_single_page"
        save_page "#{questionnaire.key}_single_page_source"
      end
    end
  end
end
