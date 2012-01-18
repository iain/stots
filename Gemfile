#!/usr/bin/env ruby
source 'https://rubygems.org'

gem 'rails', '3.2.0.rc2'

gem 'sqlite3'

gem 'haml'
gem 'friendly_id'
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'pjax_rails'
gem 'inherited_resources'

gem 'faraday'
gem 'faraday_middleware'
gem 'typhoeus'
gem 'nokogiri'

group :assets do
  gem 'compass', '~> 0.12.alpha.4'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'jquery-rails'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'shoulda-matchers'
end

group :development, :production do
  gem 'hirb', :require => false
  gem 'wirb', :require => false
end
