# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  MHM-Systemhaus GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#require 'bundler/capistrano'
require "rvm/capistrano"                               # Load RVM's capistrano plugin.
set :user, "user"
set :application, "cotopaxi"

set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :rvm_type, :user
set :domain, "cotopaxi.co"
set :repository,  "#{user}@#{domain}:git/#{application}.git"
set :deploy_to, "/Users/#{user}/#{application}"
set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :rails_env, :production

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end

  task :migrate do
    run "cd #{current_path}; rake db:migrate RAILS_ENV=#{rails_env}"
  end
end