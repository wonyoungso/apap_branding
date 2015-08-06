set :application, "assets.apap.or.kr"
set :domain, "#{application}"

require 'bundler/capistrano'
set :rbenv_ruby_version, "1.9.3-p429"

require "capistrano-rbenv"
set :user, "deployer"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/sidekiq"

set :scm, :git
set :repository, "git@github.com:wonyoungso/apap_branding.git"


set :use_sudo, false
set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitsubmodule"]
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}" 

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

server "assets.apap.or.kr", :web, :app, :db, primary: true

set :branch, "stable"
set :rails_env, 'production'
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end



# namespace :foreman do
#   # desc 'Export the Procfile to Ubuntu upstart scripts'
#   # task :export, :roles => :app do
#   #   run "cd /home/deployer/small-world.kr/current && "\
#   #       "rbenv sudo foreman export upstart /etc/init -f /home/deployer/apap.or.kr/current/Procfile.production -a apap.or.kr -u deployer -l /home/deployer/apap.or.kr/current/log/foreman"
#   # end

#   desc "Start the application services"
#   task :start, :roles => :app do
#     sudo "start #{application}"
#   end

#   desc "Stop the application services"
#   task :stop, :roles => :app do
#     sudo "stop #{application}"
#   end

#   desc "Restart the application services"
#   task :restart, :roles => :app do
#     run "#{sudo} start #{application} || #{sudo} restart #{application}"
#   end
# end

#after "deploy:update", "foreman:export"
#after "deploy:update", "foreman:restart"
