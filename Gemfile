# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Rails
gem 'rails', '>= 6.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript.
gem 'webpacker', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '3.1.12'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Spring speeds up server boot by keeping your application running in the background
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Load development and test env
  gem "dotenv", "~> 2.7"
end

group :test do
  # Test those files
  gem 'rspec-rails'
  # Adds support for Capybara system testing
  gem 'capybara', require: false
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '~> 4.0', require: false
  # Cleaning up the databases in testing
  gem 'database_cleaner-active_record', require: false
  # Gotta cover them all
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  # Code policing with rubocop
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
end

group :production do
  gem 'aws-sdk-s3', require: false
end


