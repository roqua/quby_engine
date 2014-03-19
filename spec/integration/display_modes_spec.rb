require 'spec_helper'

module Quby
  describe 'preview questionnaires in all modes', screenshots: true do
    before(:all) do
      Rails.application.config.action_dispatch.show_exceptions = true
    end

    before do
      Quby.questionnaires_path = Rails.root.join("../../db/questionnaires")

      # Don't verify HMACs or tokens
      Quby::AnswersController.any_instance.stub(verify_hmac: true)
      Quby::AnswersController.any_instance.stub(verify_token: true)

      # Don't show warning when leaving page
      Questionnaire.any_instance.stub(leave_page_alert: nil)
    end

    after(:all) do
      Rails.application.config.action_dispatch.show_exceptions = false
    end

    def visit(path, options = {})
      # Ye gods man, please don't silently fail when server
      # gives an HTTP 500
      result = page.driver.visit(path)
      if result == "fail"
        raise result
      end
      result
    end

    Quby.questionnaire_finder.all.each do |questionnaire|
      describe "#{questionnaire.key}" do
        let(:answer) { questionnaire.answers.create(token: "abcd") }

        it "screenshots #{questionnaire.key} in paged view", js: true do
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

        it "screenshots #{questionnaire.key} in bulk view", js: true do
          visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?display_mode=bulk"
          screenshot "#{questionnaire.key}_bulk"
        end
      end
    end
  end
end
