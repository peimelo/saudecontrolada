role :app, %w{ubuntu@saudecontrolada.com.br}
role :web, %w{ubuntu@saudecontrolada.com.br}
role :db,  %w{ubuntu@saudecontrolada.com.br}

set :branch, 'master'
set :deploy_to, '/var/www/saudecontrolada'
set :repo_url, 'git@github.com:peimelo/saudecontrolada.git'

server 'saudecontrolada.com.br', user: 'ubuntu', roles: %w{app}#, my_property: :my_value

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
