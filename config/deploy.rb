require 'erb'
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

namespace :deploy do
  desc "Restart web server"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Start web server"
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Stop web server"
  task :stop, :roles => :app do
    # Do nothing
  end
  
  desc "Create database.yml in shared/config" 
  task :after_setup do
    database_configuration = <<-EOF
development:
  adapter: sqlite3
  database: db/development.sqlite3
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  timeout: 5000

production:
  adapter: mysql
  database: quby_#{application}
  username: quby_#{application}
  password: roquargoc
  encoding: utf8
  host: localhost
  reconnect: true
EOF

  run "mkdir -p #{deploy_to}/#{shared_dir}/config" 
  put database_configuration, "#{deploy_to}/#{shared_dir}/config/database.yml" 
end


  desc "Link in the production database.yml" 
  task :after_update_code do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml" 
  end
end
