require 'erb'
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :scm, :git
set :repository, "git@git.roqua.nl:quby.git"
set :deploy_via, :remote_cache

set :questionnaire_repository, "git@git.roqua.nl:qubyquestionnaires.git"
set :questionnaire_branch, "master"
set :questionnaire_master_branch, "master"

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

  desc "Symlink the questionnaires from shared dir"
  task :link_shared_dirs do
    run "ln -nfs #{deploy_to}/#{shared_dir}/questionnaires #{release_path}/db/questionnaires"
  end

  desc "Create/update the questionnaires repo checkout"
  task :update_questionnaires do
    update_commands = []
    update_commands << "cd #{deploy_to}/#{shared_dir}/questionnaires"
    update_commands << "git fetch origin && git merge origin/#{questionnaire_master_branch} && git push"

    clone_commands = []
    # Set up git for committing
    clone_commands << "git config user.email \"deploy@quby.#{application}.roqua.nl\""
    clone_commands << "git config user.name \"#{application} deployed instance\""

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

  after "deploy:update_code", "deploy:link_shared_dirs"
  after "deploy:update_code", "deploy:update_questionnaires"
end
