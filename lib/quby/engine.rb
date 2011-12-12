# Engines are run as gems, not really using bundler
# Therefore, we need to require stuff manually
require 'rubygems'
require 'mongoid'
require 'mongoid-app_settings'
require 'compass'
require 'andand'

module Quby
  class Engine < Rails::Engine
    isolate_namespace Quby
  end
end
