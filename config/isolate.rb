gem 'isolate'

gem 'rack', '= 1.0.1'
gem 'rails', '= 2.3.5'

# View helpers
gem 'haml'
gem 'will_paginate'
gem 'formtastic'
gem 'rdiscount'

# Libaries
gem 'mysql'
gem 'sqlite3-ruby', '1.2.5'
gem 'andand'
gem 'awesome_print'
gem 'open4'
gem 'wirble'
gem 'json'

# Rails plugins
gem 'rails-settings' #, :lib => 'settings'
gem 'devise', '= 1.0.6'
gem 'seed-fu'

environment :test do
  gem 'rspec'
end
