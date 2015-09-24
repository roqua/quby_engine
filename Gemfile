source 'http://rubygems.org'

# Declare your gem's dependencies in quby.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'appraisal', '2.1.0'
gem 'bson_ext'

# Optional dependency on RoQua Support gem.
gem 'roqua-support'

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
  gem 'guard-rspec'
  gem 'guard-teaspoon'
  gem 'guard-rubocop'
  gem 'flamegraph'
  gem 'rspec-prof'
end
