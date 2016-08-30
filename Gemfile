source 'http://rubygems.org'

# Declare your gem's dependencies in quby.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'appraisal', '2.1.0'
gem 'bson_ext'

# Optional dependency on RoQua Support gem.
gem 'roqua-support'

gem 'i18n'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end

platforms :ruby, :jruby do
  gem 'therubyracer'
end

group :test, :development do
  gem 'guard-rspec',    '~> 4.2'
  gem 'guard-teaspoon', '~> 0.8'
  gem 'guard-spork',    '~> 2.1'
  gem 'guard-rubocop',  '~> 1.0'

  # TODO: enable again after upgrading guard and guard-teaspoon to a compatible version
  # gem 'guard-bundler',  '~> 2.1.0' 

  gem 'flamegraph',     '~> 0.0'
  gem 'stackprof' # needed by flamegraph
  gem 'rspec-prof',     '~> 0.0'
  gem 'byebug'
  gem 'test-unit'
end
