# Engines are run as gems, not really using bundler
# Therefore, we need to require stuff manually
require 'rubygems'
require 'mongoid'
require 'mongoid-app_settings'
require 'sass-rails'
require 'compass-rails'
require 'jquery-rails'
require 'fd-slider-rails'
require 'backbone-rails'
require 'susy'
require 'andand'
require 'coffee-filter'

module Quby
  class Engine < Rails::Engine
    isolate_namespace Quby

    initializer "QubyEngine precompile hook" do |app|
      app.config.assets.precompile += ["quby/application.css", "quby/print.css", "quby/dialog.css"]
      app.config.assets.precompile += ["quby/application.js", "quby/answers.js", "quby/disable_keys.js"]
    end
  end
end
