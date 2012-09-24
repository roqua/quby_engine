# Engines are run as gems, not really using bundler
# Therefore, we need to require stuff manually
require 'rubygems'
require 'mongoid'
require 'mongoid-app_settings'
require 'sass-rails'
require 'compass-rails'
require 'jquery-rails'
require 'fd-slider-rails'
require 'susy'
require 'andand'
require 'coffee-filter'

module Quby
  class Engine < Rails::Engine
    isolate_namespace Quby

    initializer "QubyEngine precompile hook" do |app|
      app.config.assets.precompile += %w(quby/application.css quby/dialog.css quby/redmond/jquery-ui-1.8.7.custom.css quby/print.css)
      app.config.assets.precompile += %w(quby/application.js quby/questionnaires.js quby/answers.js quby/disable_keys.js quby/jquery.ba-hashchange.min.js quby/jquery.placeholder.js quby/printer.js )
    end
  end
end
