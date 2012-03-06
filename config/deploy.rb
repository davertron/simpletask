set :use_sudo, false

set :application, "simpletask"
set :repository,  "git://github.com/davertron/simpletask.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "davertron.com"                          # Your HTTP server, Apache/etc
role :app, "davertron.com"                          # This may be the same as your `Web` server
role :db,  "davertron.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "/var/www/rails/simpletask"
set :user, "deploy"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
