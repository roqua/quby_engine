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
require 'jquery/rails'
require 'combustion'
Combustion.path = 'spec/internal'
Combustion.initialize! :action_controller, :action_view, :sprockets

require 'rspec/rails'
require 'database_cleaner'
require 'roqua/support/request_logger'
require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'timecop'
require 'fakefs/safe'
require 'launchy'

Capybara.default_selector = :css
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true, timeout: 120)
end
Capybara.javascript_driver = :poltergeist

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("../../spec/support/**/*.rb")].each { |f| require f }

Quby.questionnaires_path = Rails.root.join("..", "..", "spec", "fixtures")

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner[:mongoid].clean_with(:truncation)
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
    Quby.questionnaires_path = Rails.root.join("..", "..", "spec", "fixtures")
    Quby.answer_repo = Quby::AnswerRepos::MemoryRepo.new
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
