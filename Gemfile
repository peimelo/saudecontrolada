source 'https://rubygems.org'
ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
gem 'simple_form', '~> 3.1.0.rc2', github: 'plataformatec/simple_form'

# enviar e-mail em background
gem 'delayed_job_active_record'
gem 'daemons'
gem 'delayed_job_web'

# pdf
gem 'prawn'

# usar no migrate comando para gerar fk
gem 'foreigner', '~> 1.4.1'

# graficos
gem 'lazy_high_charts'

# paginacao
gem 'bootstrap-will_paginate'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development
gem 'spring-commands-rspec', group: :development

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'guard-brakeman'
  gem 'letter_opener'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'rails_best_practices'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'ruby_gntp'
  gem 'webrick', '1.3.1'
end

group :test do
  gem 'capybara'#, '~> 2.1.0'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'faker'
  gem 'launchy'#, '~> 2.3.0'
  # gem 'rack_session_access' get e set em session com capybara
  gem 'simplecov', :require => false
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'rspec-rails'#, '~> 2.14.0'
end

# Deploy
gem 'capistrano'
gem 'capistrano-bundler'
gem 'capistrano-rails'
gem 'capistrano-rbenv'
gem 'unicorn'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-linkedin'
