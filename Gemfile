source 'https://rubygems.org'

# Declare your gem's dependencies in quby.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.

gemspec

gem 'appraisal', '2.1.0'

# Optional dependency on RoQua Support gem.
gem 'roqua-support'

gem 'i18n'

gem 'jquery-ui-rails', '~> 3.0.1'
gem 'susy', '~> 2.2.12'
gem 'compass-rails'

gem 'nokogumbo'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end

platforms :ruby, :jruby do
  gem 'therubyracer'
end

group :test do
  gem 'rails-controller-testing'
end

group :test, :development do
  gem 'guard-rspec',         '>= 4.2'
  gem 'guard-teaspoon',      '~> 0.8'
  gem 'guard-spork',         '~> 2.1'
  gem 'guard-rubocop',       '~> 1.0'
  gem 'capybara',            '~> 3.0'
  gem 'capybara-screenshot', '~> 1.0'
  gem 'selenium-webdriver',  '~> 3.14'
  gem 'timecop'
  gem 'fakefs', '0.9.1', require: false
  gem 'pry-coolline'

  # TODO: enable again after upgrading guard and guard-teaspoon to a compatible version
  # gem 'guard-bundler',  '~> 2.1.0'

  gem 'flamegraph'
  gem 'stackprof' # needed by flamegraph
  gem 'test-unit'

  gem 'rspec-rails'
  gem 'rspec-core'
end
