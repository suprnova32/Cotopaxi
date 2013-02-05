##### Requirement's #####
require 'bundler/capistrano'
require 'capistrano/ext/multistage'

#### Use the asset-pipeline

#load 'deploy/assets'

##### Stages #####
set :stages, %w(production staging)

##### Constant variables #####
set :application, "rails1"
set :deploy_to,   "/var/www/#{application}"
set :user, "deploy"
set :use_sudo, false


##### Default variables #####
set :keep_releases, 10

##### Repository Settings #####
set :scm,        :git
set :repository, "git://github.com/MHM-HR/Cotopaxi.git"

##### Additional Settings #####
#set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

#### Roles #####
# See Stages

##### Overwritten and changed default capistrano tasks #####
namespace :deploy do

  # Restart Application
  desc "Restart RailsApp"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Additional Symlinks"
  task :additional_symlink, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Addtional Rake Tasks"
  task :additional_rake, :roles => :app, :only => {:primary => true} do

  end

  desc "Seed database"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end

  task :migrate do
    run "cd #{current_path}; rake db:migrate RAILS_ENV=#{rails_env}"
  end
end
  
##### After and Before Tasks #####
before "deploy:assets:precompile", "deploy:additional_symlink"
after "deploy", "deploy:additional_rake"
after "deploy:restart", "deploy:cleanup"
