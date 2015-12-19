# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'saudecontrolada'
set :rails_env, 'production'

set :rbenv_ruby, '2.2.3'
set :rbenv_path, '~/.rbenv'

#set :unicorn_config_path, '/var/www/saudecontrolada/current/config/unicorn.rb'

#set :rbenv_type, :deploy

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
#set :deploy_to, '/var/www/saudecontrolada'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/env.rb}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# require 'airbrake/capistrano3'
# after 'deploy:finished', 'airbrake:deploy'
