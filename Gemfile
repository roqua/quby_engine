source 'https://rubygems.org'

# Declare your gem's dependencies in quby.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.

gemspec

gem 'appraisal', '2.1.0'

# Optional dependency on RoQua Support gem.
gem 'roqua-support'

gem 'i18n'

gem 'susy', '~> 2.2.12'
gem 'compass-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end

group :test do
  gem 'rails-controller-testing'
end

group :test, :development do
  gem 'guard-rspec',         '>= 4.2'
  gem 'guard-teaspoon'
  gem 'guard-spork',         '~> 2.1'
  gem 'guard-rubocop',       '~> 1.0'
  gem 'capybara',            '~> 3.0'
  gem 'capybara-screenshot', '~> 1.0'
  gem 'selenium-webdriver',  '~> 3.14'
  gem 'timecop'
  gem 'fakefs', '0.9.1', require: false

  # TODO: enable again after upgrading guard and guard-teaspoon to a compatible version
  # gem 'guard-bundler',  '~> 2.1.0'

  gem 'flamegraph'
  gem 'stackprof' # needed by flamegraph
  gem 'test-unit'

  gem 'rspec-rails'
  gem 'rspec-core'
  gem 'quby-compiler', git: 'https://gitlab.roqua.nl/roqua/quby-compiler', branch: 'main', require: false
  # gem 'quby-compiler', path: '../quby-compiler', require: false
end
