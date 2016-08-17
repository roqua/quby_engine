# Engines are run as gems, not really using bundler
# Therefore, we need to require stuff manually
require 'rubygems'
require 'coffee_script'
require 'haml'
require 'sass-rails'
require 'compass'
require 'compass-rails'
require 'compass-blueprint'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'susy'
require 'andand'
require 'quby/lookup_table'

module Quby
  class Engine < Rails::Engine
    isolate_namespace Quby

    initializer "QubyEngine precompile hook" do |app|
      app.config.assets.precompile += ["quby/application.css", "quby/print.css", "quby/dialog.css"]
      app.config.assets.precompile += ["quby/application.js", "quby/answers.js", "quby/disable_keys.js",
                                       "quby/printer.js"]
    end
  end
end
