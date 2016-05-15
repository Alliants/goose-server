source 'https://rubygems.org'

ruby "2.3.0"

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'puma'
gem 'grape'
gem 'hashie-forbidden_attributes' # We will be using Grape's own validations
gem 'octokit'
gem 'faraday-http-cache' # only used for Octokit caching
gem 'rack-cors', '~> 0.4.0'
gem 'newrelic_rpm'

group :deployment do
  gem 'mina'
  gem 'mina-puma'
  gem 'dotenv'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'rspec-rails', '~> 3.0'
end
