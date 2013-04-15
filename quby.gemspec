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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.markdown"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1"

  # Databases
  s.add_dependency "mongoid", "~> 2.2"

  # Views
  s.add_dependency "haml"
  s.add_dependency "sass-rails"
  s.add_dependency "maruku"
  s.add_dependency "compass-rails", '1.0.1'
  s.add_dependency "susy", "~> 1.0.rc"
  s.add_dependency "coffee-filter"
  s.add_dependency "rails-backbone"

  # Helpers
  s.add_dependency "ryansch-andand"
  s.add_dependency "json"
  s.add_dependency "addressable"
  s.add_dependency "mongoid-app_settings"
  s.add_dependency "virtus", "~> 0.5.4"

  s.add_dependency "jquery-rails", "~> 2.1.3"
  s.add_dependency "fd-slider-rails", "~> 0.5.1"

  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "launchy"
  s.add_development_dependency "pry"
end
