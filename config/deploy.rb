# rvm
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"                              # Load RVM's capistrano plugin.

set :rvm_ruby_string, 'ruby-1.9.3-p0'        
set :rvm_type, :user

set :application, "rapture"

# Repository
set :repository, "git@github.com:fadendaten/rapture.git"
set :scm, :git
set :branch, "master"

# Test Server sv96.aarboard.ch
role :web, "sv96.aarboard.ch"                          # Your HTTP server, Apache/etc
role :app, "sv96.aarboard.ch"                          # This may be the same as your `Web` server
role :db,  "sv96.aarboard.ch", :primary => true        # This is where Rails migrations will run

# Server Details
set :deploy_to, "/home/nile/rapture/htdocs/#{application}" #folder where we are deploying to.
set :deploy_via, :copy
set :use_sudo, false
set :port, 2560
set :user, "rapture" #ssh user
set :password, "pR9hemex"

# If you are using Passenger mod_rails uncomment this:

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public"
  end
end

#this is for updating gemset after svn update
namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
  
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end
  
  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end
  
  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end

# HOOKS
after "deploy:update_code" do
  bundler.bundle_new_release
  deploy.symlink_shared
end

require File.dirname(__FILE__) + "/boot.rb"
#require 'hoptoad_notifier/capistrano'