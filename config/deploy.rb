require 'erb'
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :scm, :git
set :repository, "git@github.com:roqua/quby.git"
set :branch,     "rel_201106"
set :deploy_via, :remote_cache

set :questionnaire_repository, "git@github.com:roqua/questionnaires.git"
set :questionnaire_branch, "master"
set :questionnaire_master_branch, "master"

set :user, "deploy"
set :use_sudo, false

ssh_options[:forward_agent] = true

set :default_env,  'production'
set :rails_env,     ENV['rails_env'] || ENV['RAILS_ENV'] || default_env

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

  desc "Link in the shared config files"
  task :link_database_yml do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"

    # if a shared copy of newrelic.yml exists, use that, otherwise the repo version is fine
    # we use this to disable newrelic in the rgoc app
    run "if [ -e #{deploy_to}/#{shared_dir}/config/newrelic.yml ]; then ln -nfs #{deploy_to}/#{shared_dir}/config/newrelic.yml #{release_path}/config/newrelic.yml; fi"
  end

  desc "Symlink the questionnaires from shared dir"
  task :link_shared_dirs do
    run "ln -nfs #{deploy_to}/#{shared_dir}/questionnaires #{release_path}/db/questionnaires"
  end

  desc "Seed"
  task :seed, :roles => :db do
    run "cd #{release_path}; bundle exec rake RAILS_ENV=#{rails_env} db:seed"
  end

  desc "Create/update the questionnaires repo checkout"
  task :update_questionnaires do
    update_commands = []
    update_commands << "cd #{deploy_to}/#{shared_dir}/questionnaires"
    update_commands << "git fetch origin && git merge origin/#{questionnaire_master_branch} && git push origin #{questionnaire_branch}"

    clone_commands = []
    # Clone git repo
    clone_commands << "cd #{deploy_to}/#{shared_dir}"
    clone_commands << "git clone #{questionnaire_repository} questionnaires"

    # Check out correct branch
    if questionnaire_branch != "master"
      clone_commands << "cd #{deploy_to}/#{shared_dir}/questionnaires"
      clone_commands << "git checkout -b #{questionnaire_branch} origin/#{questionnaire_branch}"
    end

    command = "if [ -d #{deploy_to}/#{shared_dir}/questionnaires ]; then " +
                update_commands.join(" && ") + "; " +
              "else " +
                clone_commands.join(" && ") + "; " +
              "fi"

    run command
  end

  after "deploy:update_code", "deploy:link_database_yml"
  after "deploy:update_code", "deploy:link_shared_dirs"
  after "deploy:update_code", "deploy:update_questionnaires"
  after "deploy:migrate", "deploy:seed"
end

namespace :logs do
  task :watch do
    stream("tail -n 50 -f #{deploy_to}/#{shared_dir}/log/production.log")
  end
end
