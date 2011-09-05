source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'
gem 'mysql2', "=0.3.7"

gem 'haml'
gem 'formtastic'
gem 'maruku'

gem 'newrelic_rpm'
gem 'andand'
gem 'awesome_print'
gem 'open4'
gem 'wirble'
gem 'json'
gem 'addressable'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'compass', :git => 'git://github.com/chriseppstein/compass.git', :branch => 'rails31'
end

gem 'jquery-rails'

gem 'exception_notification'
gem 'rails3-settings', :git => 'git://github.com/roqua/rails-settings.git', :require => 'settings'
gem 'devise', "~> 1.1"

# gem "central_logger" # disabled until fixed for when no connection is made
gem 'SystemTimer', :platforms => [:ruby_18]

group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
end

group :test, :development do
  gem 'foreman'
  gem "rspec-rails", ">= 2.0.0.beta.19"
  gem "autotest"
  gem "webrat"
end
