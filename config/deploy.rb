require 'erb'
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :scm, :git
set :repository, "git@git.roqua.nl:quby.git"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

set :user, "deploy"
set :use_sudo, false

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
  
  desc "Link in the production database.yml" 
  task :after_update_code do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml" 
  end
end
