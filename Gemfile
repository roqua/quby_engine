source 'http://rubygems.org'

# Declare your gem's dependencies in quby.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'rails', '3.2.17'

gem 'bson_ext'

# Optional dependency on RoQua Support gem.
gem 'roqua-support', git: 'git://github.com/roqua/roqua-support.git'
gem 'roqua-opencpu', path: '../roqua-opencpu'

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
#
# OLD GEMFILE:
#source 'http://rubygems.org'

gem 'open4'
gem 'wirble'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass'
end

platforms :ruby, :jruby do
  gem 'therubyracer'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'teaspoon',            '~> 0.7.9'
  gem 'spork'
  gem 'rubocop',             '~> 0.19.0'

  gem 'guard-rspec'
  gem 'guard-teaspoon'
  gem 'guard-spork'
  gem 'guard-rubocop'

  gem 'fakefs', :require => 'fakefs/safe'
end

group :test do
  gem 'fuubar'
  gem 'timecop'

  # brew install phantomjs
  #gem 'poltergeist'
end
