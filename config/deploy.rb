# config valid only for current version of Capistrano
lock "3.8.2"

# set :application, "my_app_name"
# set :repo_url, "git@example.com:me/my_repo.git"

set :application, 'steemit'
set :repo_url, 'git@github.com:kuissoft/steemit.git'

set :deploy_to, '/home/ubuntu/condenser'

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: true
}

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :pm2_app_command, 'app.coffee'                   # the main program
set :pm2_app_name, fetch(:application)            # name for pm2 app
set :pm2_target_path, -> { release_path }         # where to run pm2 commands
set :pm2_roles, :all                              # server roles where pm2 runs on
set :pm2_env_variables, {}                        # default: env vars for pm2
set :pm2_start_params, ''                         # pm2 start params see http://pm2.keymetrics.io/docs/usage/quick-start/#cheat-sheet

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'pm2:restart'
  end

  after :publishing, :restart
end