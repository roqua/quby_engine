# frozen_string_literal: true

ENV["RAILS_ENV"] ||= 'test'
ENV["MONGOID_ENV"] = "test"

require 'rubygems'
require 'bundler/setup'

if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'jquery-rails'
require 'jquery-ui-rails'

require 'combustion'
require 'stackprof'
Combustion.path = 'spec/internal'
Combustion.initialize! :action_controller, :action_view, :sprockets do
  config.action_view.raise_on_missing_translations = true
end
I18n.exception_handler = lambda do |exception, locale, key, options|
  fail "translation error: #{exception}, #{options}"
end

require 'rspec/rails'
require 'rails-controller-testing'

require 'quby/compiler'
require 'roqua/support/request_logger'
require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'timecop'
require 'fakefs/safe'
require 'launchy'
require 'selenium-webdriver'

# Load up shared examples
require 'quby/answers/specs'
require 'quby/questionnaires/specs'

Capybara.default_selector = :css
if ENV['SELENIUM_HOST'].present? && ENV['TEST_APP_PORT'].present?
  # we live in docker-compose,
  # dependencies can't easily link back to main service by using service name as hostname,
  # so we find our ip.
  docker_ip = `hostname -i`.strip
  Capybara.app_host = "http://#{docker_ip}" #:#{ENV['TEST_APP_PORT']}"
  Capybara.server_host = '0.0.0.0'
  Capybara.server_port = ENV['TEST_APP_PORT']
  selenium_url = "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub"
end
Capybara.always_include_port = true
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 url: selenium_url,
                                 options: options
end
Capybara.javascript_driver = :selenium_chrome_headless
Capybara::Screenshot.register_driver(:selenium_chrome_headless) do |driver, path|
  driver.browser.save_screenshot(path)
end
Capybara.server = :webrick

# This needs to happen once before the :each block so that spec/features/display_modes_spec.rb
# can iterate over all fixtures and add specs for each of them.
Quby.questionnaire_repo = Quby::Questionnaires::Repos::DiskRepo.new(Quby.fixtures_path)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("../../spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Capybara::DSL

  config.infer_spec_type_from_file_location!
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  # config.full_backtrace = true

  # Disabled for now. Will do a cleanup in a different pull request.
  # config.raise_errors_for_deprecations!

  if Rails.version >= '5' && Gem.loaded_specs['rspec-rails'].version.version < '3.5'
    [:controller, :view, :request].each do |type|
      config.include ::Rails::Controller::Testing::TestProcess, type: type
      config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
      config.include ::Rails::Controller::Testing::Integration, type: type
    end
  end

  config.before(:each) do
    Quby.questionnaire_repo = Quby::Questionnaires::Repos::DiskRepo.new(Quby.fixtures_path)
    Quby.answer_repo = Quby::Answers::Repos::MemoryRepo.new
  end
end
