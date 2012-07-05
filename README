Quby
====

## Usage

Quby is a Rails 3.1 Mountable Engine, which means that you have to mount it
into your existing Rails application. First, you need to include Quby as a gem in your Gemfile:

    gem 'quby', :git => "git://github.com/roqua/quby.git"

Then, mount it at a path in your application. You can do this by putting a line
in config/routes.rb. Note that "/quby" could be anything you want.

    mount Quby::Engine => "/quby", :as => "quby_engine"

In config/initializers/quby.rb, you need to tell Quby where it can find its questionnaire definitions.

    Quby.questionnaires_path = "db/questionnaires"
    Quby.functions_path      = "db/functions"

## Contributing to Quby
 
* Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it
  and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to
  have your own version, or is otherwise necessary, that is fine, but please
  isolate to its own commit so I can cherry-pick around it.