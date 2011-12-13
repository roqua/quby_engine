$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quby/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quby"
  s.version     = Quby::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Quby."
  s.description = "TODO: Description of Quby."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"

  # Databases
  s.add_dependency "mysql2", "=0.3.7"
  s.add_dependency "mongoid", "~> 2.2"

  # Views
  s.add_dependency "haml"
  s.add_dependency "maruku"
  s.add_dependency "compass", "~> 0.12.alpha.0"

  # Helpers
  s.add_dependency "andand"
  s.add_dependency "json"
  s.add_dependency "addressable"
  s.add_dependency "mongoid-app_settings"

  s.add_dependency "jquery-rails", "1.0.13"

  s.add_development_dependency "database_cleaner"
end
