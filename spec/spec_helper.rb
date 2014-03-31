require 'rubygems'
require 'bundler/setup'
require 'database_cleaner'
require 'timecop'
require 'roqua/support/request_logger'

if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

ENV["RAILS_ENV"] ||= 'test'
ENV["MONGOID_ENV"] = "test"

# if Mongoid::VERSION > '3'
#   Mongoid.load!("#{File.dirname(__FILE__)}/mongoid3.yml")
# else
#   Mongoid.load!("#{File.dirname(__FILE__)}/mongoid2.yml")
# end
# Mongoid.logger.level = Logger::INFO


require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
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

# This code will be run each time you run your specs.

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("../../spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner[:mongoid].clean_with(:truncation)
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
    Quby.questionnaires_path = Rails.root.join("..", "..", "spec", "fixtures")
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
