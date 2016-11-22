#!/usr/bin/env rake
begin
  require 'bundler/setup'
  Bundler.require
  # get the rails rake tasks to test things like assets:precompile.
  require 'combustion'
  Combustion::Application.config.middleware.delete Sass::Plugin::Rack # https://github.com/rails/sass-rails/issues/136
  Combustion.initialize!
  Combustion::Application.load_tasks
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Quby'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Let's not have a rake task that pushes our closed-source app to rubygems.org
#Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
