# This file allows you to override various Teaspoon configuration directives when running from the command line. It is
# not required from within the Rails environment, so overriding directives that have been defined within the initializer
# is not possible.
#
# Set RAILS_ROOT and load the environment.
# ENV["RAILS_ROOT"] = File.expand_path("../dummy/", __FILE__)
# require File.expand_path("../dummy/config/environment", __FILE__)

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'jquery/rails'
require 'combustion'
Combustion.path = 'spec/internal'

require 'quby'
require 'teaspoon'

if Rails.env.test? || Rails.env.development?
  Rails.application.config.assets.paths << Quby::Engine.root.join("spec", "javascripts") <<
      Quby::Engine.root.join("spec", "stylesheets")
  # Add engine to view path so that spec/javascripts/fixtures are accessible
  ActionController::Base.prepend_view_path Quby::Engine.root
end

Combustion.initialize! :action_controller, :action_view, :sprockets

# Provide default configuration.
#
# You can override various configuration directives defined here by using arguments with the teaspoon command.
#
# teaspoon --driver=selenium --suppress-log
# rake teaspoon DRIVER=selenium SUPPRESS_LOG=false
Teaspoon.setup do |config|
  # Driver / Server
  # config.driver              = "phantomjs" # available: phantomjs, selenium
  # config.server              = nil # defaults to Rack::Server

  # Behaviors
  # config.server_timeout      = 20 # timeout for starting the server
  # config.server_port         = nil # defaults to any open port unless specified
  # config.fail_fast           = true # abort after the first failing suite

  # Output
  # config.formatters          = "dot" # available: dot, tap, tap_y, swayze_or_oprah
  # config.suppress_log        = false # suppress logs coming from console[log/error/debug]
  # config.color               = true

  # Coverage (requires istanbul -- https://github.com/gotwarlost/istanbul)
  # config.coverage                      = true
  # config.coverage_reports              = "text,html,cobertura"
  # config.coverage_output_dir           = "coverage"
  # config.statements_coverage_threshold = 50
  # config.functions_coverage_threshold  = 50
  # config.branches_coverage_threshold   = 50
  # config.lines_coverage_threshold      = 50
end
