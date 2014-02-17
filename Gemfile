source 'https://rubygems.org'

ruby '2.1.0'

gem 'thin', require: false

gem 'sinatra',         '~> 1.4.4', require: ['sinatra/base', 'sinatra/multi_route']
gem 'sinatra-contrib', '~> 1.4.2'
gem 'sinatra-partial',             require: 'sinatra/partial'
gem 'sinatra-support', '~> 1.2.2', require: 'sinatra/support/i18nsupport'

gem 'rack-flash3',     '~> 1.0.5', require: 'rack-flash'
gem 'sinatra-redirect-with-flash', require: 'sinatra/redirect_with_flash'

gem 'i18n'

gem 'pg', require: false
gem 'sequel', '~> 4.7.0'
gem 'bcrypt-ruby', '~> 3.1.2', require: 'bcrypt'

gem 'sass', '~> 3.2.14'

group :development do
  gem 'awesome_print',    require: false
  gem 'rerun',            require: false
  gem 'pry',              require: false
  gem 'faker',            require: false
end

group :test do
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
end

