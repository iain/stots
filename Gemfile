#!/usr/bin/env ruby
source 'https://rubygems.org'

gem 'rails'

gem 'mysql2'

gem 'haml'
gem 'friendly_id'
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'pjax_rails'
gem 'inherited_resources'
gem 'will_paginate'
gem 'has_scope'

gem 'faraday'
gem 'faraday_middleware'
gem 'typhoeus'
gem 'nokogiri'
gem 'foreman'

gem 'thin'

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
