require "bundler/capistrano"
require "rvm/capistrano"
require 'sidekiq/capistrano'
 
role :web, "54.94.156.78"                          # Your HTTP server, Apache/etc
role :app, "54.94.156.78"                          # This may be the same as your `Web` server
role :db,  "54.94.156.78", :primary => true # This is where Rails migrations will run
role :db,  "54.94.156.78"

set :host, "54.94.156.78" 
set :application, "startupplace_site"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
 
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository, "https://github.com/StartupPlace/new.startupplace.git"
set :branch, "master"
set :scm_passphrase, ""
 
 
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = "~/sp-site.pem"
 
# before 'deploy:setup', 'rvm:install_rvm'
after "deploy", "deploy:cleanup" # keep only the last 5 releases
 
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
 
namespace :deploy do

	task :setting_permission_on_unicorn_file, roles: :app do
    run "chmod +x #{current_path}/config/unicorn_init.sh"
	end
	before "deploy:restart", "deploy:setting_permission_on_unicorn_file"

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  # namespace :assets do
  #   desc 'Run the precompile task locally and rsync with shared'
  #   task :precompile, :roles => :web, :except => { :no_release => true } do
  #     from = source.next_revision(current_revision)
  #     if releases.length <= 1 || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
  #       %x{bundle exec rake assets:precompile}
  #       %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{host}:#{shared_path}}
  #       %x{bundle exec rake assets:clean}
  #     else
  #       logger.info 'Skipping asset pre-compilation because there were no asset changes'
  #     end
  #   end
  # end
 
  desc "Make sure config local."
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "deploy:setup_config"
 
  desc "Create symlink of database.yml"
  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"
 
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push origin master` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

# namespace :bundle do
#   desc "run bundle install and ensure all gem requirements are met"
#   task :install do
#     run "cd #{current_path} && bundle install --without=test"
#   end
# end
# before "deploy:restart", "bundle:install"