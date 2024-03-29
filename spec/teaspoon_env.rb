# frozen_string_literal: true

# This file allows you to override various Teaspoon configuration directives when running from the command line. It is
# not required from within the Rails environment, so overriding directives that have been defined within the initializer
# is not possible.
#
# Set RAILS_ROOT and load the environment.
# ENV["RAILS_ROOT"] = File.expand_path("../dummy/", __FILE__)
# require File.expand_path("../dummy/config/environment", __FILE__)

unless defined? Rails
  require 'rails'
  require 'rails-controller-testing' if Rails.version >= '5'
  require 'action_controller/railtie'
  require 'action_view/railtie'
  require 'sprockets/railtie'
  require 'jquery-rails'
  require 'jquery-ui-rails'
  require 'combustion'
  Combustion.path = 'spec/internal'
  require 'quby'
  require 'selenium-webdriver'
  require 'teaspoon-jasmine'

  if Rails.env.test? || Rails.env.development?
    Rails.application.config.assets.paths << Quby::Engine.root.join("spec", "javascripts") <<
        Quby::Engine.root.join("spec", "stylesheets")
    # Add engine to view path so that spec/javascripts/fixtures are accessible
    ActionController::Base.prepend_view_path Quby::Engine.root
  end

  Combustion.initialize! :action_controller, :action_view, :sprockets
end

# Provide default configuration.
#
# You can override various configuration directives defined here by using arguments with the teaspoon command.
#
# teaspoon --driver=selenium --suppress-log
# rake teaspoon DRIVER=selenium SUPPRESS_LOG=false
Teaspoon.configure do |config|

  # This determines where the Teaspoon routes will be mounted. Changing this to "/jasmine" would allow you to browse to
  # http://localhost:3000/jasmine to run your specs.
  config.mount_at = "/teaspoon"

  config.driver = :selenium


  chrome_options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'disable-gpu'])
  desired_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chrome_options: chrome_options
  )
  options = if ENV['SELENIUM_HOST'].present?
    docker_ip = `hostname -i`.strip
    config.server_host = docker_ip
    config.server_port = ENV['TEST_APP_PORT']
    http_client = Selenium::WebDriver::Remote::Http::Default.new(read_timeout: 20)
    {
      client_driver: :remote,
      selenium_options: {
        url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
        http_client: http_client,
        desired_capabilities: desired_capabilities
      }
    }
  else
    {
      client_driver: :chrome,
      selenium_options: {
        desired_capabilities: desired_capabilities
      }
    }
  end

  config.driver_options = options

  # This defaults to Rails.root if left nil. If you're testing an engine using a dummy application it can be useful to
  # set this to your engines root.. E.g. `Teaspoon::Engine.root`
  config.root = Quby::Engine.root

  # These paths are appended to the Rails assets paths (relative to config.root), and by default is an array that you
  # can replace or add to.
  config.asset_paths = ["spec/javascripts", "spec/javascripts/stylesheets"]

  # Fixtures are rendered through a standard controller. This means you can use things like HAML or RABL/JBuilder, etc.
  # to generate fixtures within this path.
  config.fixture_paths = ["spec/javascripts/fixtures"]

  # You can modify the default suite configuration and create new suites here. Suites can be isolated from one another.
  # When defining a suite you can provide a name and a block. If the name is left blank, :default is assumed. You can
  # omit various directives and the defaults will be used.
  #
  # To run a specific suite
  #   - in the browser: http://localhost/teaspoon/[suite_name]
  #   - from the command line: rake teaspoon suite=[suite_name]
  config.suite do |suite|
    suite.use_framework :jasmine, "2.2.0"

    # You can specify a file matcher and all matching files will be loaded when the suite is run. It's important that
    # these files are serve-able from sprockets.
    #
    # Note: Can also be set to nil.
    suite.matcher = "{spec/javascripts,app/assets}/**/*_spec.{js,js.coffee,coffee}"

    # Each suite can load a different helper, which can in turn require additional files. This file is loaded before
    # your specs are loaded, and can be used as a manifest.
    suite.helper = "spec_helper"

    # When running coverage reports, you probably want to exclude libraries that you're not testing.
    # Accepts an array of filenames or regular expressions. The default is to exclude assets from vendors or gems.
    # suite.no_coverage = [%r{/lib/ruby/gems/}, %r{/vendor/assets/}, %r{/support/}, %r{/(.+)_helper.}]
    # suite.no_coverage << "jquery.min.js" # excludes jquery from coverage reports

  end

  config.coverage do |coverage|
    coverage.ignore += [%r{/lib/ruby/gems/}, %r{/vendor/assets/}, %r{/support/}, %r{/(.+)_helper.}]
  end

  # Example suite. Since we're just filtering to files already within the root spec/javascripts, these files will also
  # be run in the default suite -- but can be focused into a more specific suite.
  # config.suite :targeted do |suite|
  #   suite.matcher = "spec/javascripts/targeted/*_spec.{js,js.coffee,coffee}"
  # end

end if defined?(Teaspoon) && Teaspoon.respond_to?(:setup) # let Teaspoon be undefined outside of development/test/asset
# groups
