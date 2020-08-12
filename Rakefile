#!/usr/bin/env rake
# frozen_string_literal: true

begin
  require 'bundler/setup'
  Bundler.require
  # get the rails rake tasks to test things like assets:precompile.
  require 'combustion'
  # Combustion::Application.config.middleware.delete Sass::Plugin::Rack # https://github.com/rails/sass-rails/issues/136
  Combustion.initialize!
  Combustion::Application.load_tasks
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
