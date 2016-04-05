$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quby/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quby"
  s.version     = Quby::VERSION
  s.authors     = ["Marten Veldthuis", "Jorn van de Beek", "Samuel Esposito", "Ando Emerencia"]
  s.email       = ["m.veldthuis@roqua.nl", "j.beek@roqua.nl", "s.esposito@roqua.nl", "a.emerencia@roqua.nl"]
  s.homepage    = "http://www.roqua.nl"
  s.summary     = "Questionnaire engine"
  s.description = "Quby is a Rails engine that can render and update answers for questionnaires defined in a custom DSL."
  s.license     = 'Unlicensed'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.markdown"]
  s.test_files = Dir["spec/**/*"]

  s.required_ruby_version = '>= 2.0'
  s.add_dependency "rails", ">= 4.0", '< 5.0'

  # External (web-)services
  s.add_dependency "opencpu",       '~> 0.9.0'

  # Views
  s.add_dependency 'coffee-rails'
  s.add_dependency "haml"
  # Lock sass-rails to prevent warnings and errors:
  # - .css.scss filename warnings
  # - Undefined variable: "$experimental-support-for-mozilla".
  # - Poltergeist/Capybara MouseClick errors
  s.add_dependency "sass-rails",    '4.0.5'
  s.add_dependency "maruku",        '0.6.1'
  s.add_dependency "compass",       '~> 0.12'
  s.add_dependency "compass-rails", '< 3.0'
  s.add_dependency "compass-blueprint"
  s.add_dependency "susy", "~> 1.0.rc"

  # Helpers
  s.add_dependency "ryansch-andand"
  s.add_dependency "json"
  s.add_dependency "addressable"
  s.add_dependency "virtus", ">= 1.0.3", "< 2.0"
  s.add_dependency "i18n", "~> 0.6"

  s.add_dependency "jquery-rails", "~> 2.2.1"

  s.add_development_dependency 'combustion',       '~> 0.5.4'
  s.add_development_dependency 'rspec-rails',      '~> 3.4'
  s.add_development_dependency 'rspec-its',        '~> 1.2.0'
  s.add_development_dependency 'capybara',         '~> 2.6.2'
  s.add_development_dependency 'teaspoon',         '~> 1.1.5'
  s.add_development_dependency 'rubocop',          '~> 0.20'
  s.add_development_dependency 'fakefs'
  s.add_development_dependency 'timecop'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "launchy"
  s.add_development_dependency "pry"
  s.add_development_dependency 'capybara-screenshot', '~> 1.0.11' # '= 0.3.14'
  s.add_development_dependency "codeclimate-test-reporter"
  s.add_development_dependency 'simplecov', '~> 0.9.0'
end
