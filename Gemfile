source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Caching Strategy
gem 'redis-rails'

# Serialization
gem 'active_model_serializers', '~> 0.10.0'

# Rake limits and throttling
gem 'rack-attack'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# API documentation
gem 'swagger-docs'
gem 'swagger_ui_engine', '~> 1.1.0'

# Use Factory Girl for generating random test data
gem 'factory_bot_rails', '~> 4.8.2'

# Fake content generator
gem 'faker', '~> 1.8.7'

# Pagination
gem 'will_paginate', '~> 3.1.6'
gem 'api-pagination', '~> 4.6.3'

# Searching Strategy
gem 'ransack', '~> 1.8.3'

# Worker
gem 'sinatra', github: 'sinatra/sinatra', ref: "88a1ba7bfb2262b68391d2490dbb440184b9f838"
gem 'sidekiq', '~> 5.0.5'
gem 'sidekiq-status', '~> 0.7.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'awesome_print'
  gem 'rspec-rails', '~> 3.7.2'
  gem 'dotenv-rails', '~> 2.2.1'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0.1'
  gem 'simplecov', '~> 0.12.0', require: nil
  gem 'database_cleaner', '~> 1.6.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
