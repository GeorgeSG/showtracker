source 'https://rubygems.org'

ruby '2.1.0'

gem 'sinatra',              '~> 1.4.4', require: 'sinatra/base'
gem 'sinatra-contrib',      '~> 1.4.2'
gem 'activerecord',         '~> 4.0.2'
gem 'sinatra-activerecord', '~> 1.2.3', require: false

group :development do
  gem 'sqlite3', '~>1.3', require: false
  gem 'awesome_print',    require: false
  gem 'rerun',            require: false
  gem 'pry',              require: false
end

group :production do
  gem 'pg', require: false
end
