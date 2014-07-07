Quby
====
[![CircleCI](https://circleci.com/gh/roqua/quby_engine.png?circle-token=b8c29e6c847094da985e5cbcd0e20648b11f0217)](https://circleci.com/gh/roqua/quby_engine)
[![Code Climate](https://codeclimate.com/repos/50a0b29456b1025ac6000437/badges/476040b8e82af8e87adf/gpa.png)](https://codeclimate.com/repos/50a0b29456b1025ac6000437/feed)

## Usage

Quby is a Rails mountable engine, which means that you have to mount it
into your existing Rails application. First, you need to include Quby as a gem in your Gemfile:

```ruby
gem 'quby',         git: "git@github.com:roqua/quby_engine.git"
gem 'quby-mongoid'
```

Then, mount it at a path in your application. You can do this by putting a line
in config/routes.rb. Note that "/quby" could be anything you want.

```ruby
mount Quby::Engine => "/quby", :as => "quby_engine"
```

In config/initializers/quby.rb, you need to tell Quby where it can find its questionnaire definitions,
and where it can store it's answers.

```ruby
Quby.questionnaire_repo = Quby::Questionnaires::Repos::DiskRepo.new(Rails.root.join("db/questionnaires"))
Quby.answer_repo        = Quby::Answers::Repos::MongoidRepo.new
```

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
