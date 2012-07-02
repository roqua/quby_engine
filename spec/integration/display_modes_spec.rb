require 'spec_helper'

module Quby
  describe 'preview questionnaires in all modes', :screenshots => true do
    before(:all) do
      Rails.application.config.action_dispatch.show_exceptions = true
    end

    before do
      Quby.questionnaires_path = Rails.root.join("../../db/questionnaires")
      puts Quby.questionnaires_path
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

    def screenshot(name, options = {})
      if height = options[:height]
        page.driver.resize(screen_width, height)
      end
      page.driver.render "doc/manual_roqua/materiaal/#{name}.png"
      if options[:height]
        page.driver.resize(screen_width, screen_height)
      end
    end


    it 'should work', js: true do
      Quby::AnswersController.any_instance.stub(:verify_hmac => true)
      Quby::AnswersController.any_instance.stub(:verify_token => true)
      puts Rails.version
      puts Rails.application.config.assets.paths
      questionnaire = Questionnaire.find_by_key "honos"
      answer        = questionnaire.answers.create(:token => "abcd")
      visit "/quby/questionnaires/#{questionnaire.key}/answers/#{answer.id}/edit?token=abcd"
      screenshot "#{questionnaire.key}_paged"
    end
    
  end
end
