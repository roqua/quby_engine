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
  # config.action_view.raise_on_missing_translations = true # only works for rails > 4.1
end
I18n.exception_handler = lambda do |exception, locale, key, options|
  fail "translation error: #{exception}, #{options}"
end

require 'rspec/rails'
require 'rails-controller-testing' if Rails.version >= '5'

require 'roqua/support/request_logger'
require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'timecop'
require 'fakefs/safe'
require 'launchy'

# Load up shared examples
require 'quby/answers/specs'
require 'quby/questionnaires/specs'

Capybara.default_selector = :css
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true, timeout: 120)
end
Capybara.javascript_driver = :poltergeist

# Haml 5.0 escapes interpolated code in filters, not good.
Haml::Template.options[:escape_html] = false

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
  config.raise_errors_for_deprecations!

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
