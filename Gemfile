source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '~> 5.1.3'

gem 'active_model_serializers', '~> 0.10.0'
gem 'bcrypt', '~> 3.1.7'
gem 'exception_notification'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development do
  gem 'annotate'
  gem 'brakeman', require: false
  gem 'guard'
  gem 'guard-rspec', require: false

  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'rails_best_practices', require: false
  gem 'rubocop', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'selenium-webdriver'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'launchy' #, require: false
  gem 'shoulda-matchers', '~> 3.1.0'
  gem 'simplecov', require: false
end
