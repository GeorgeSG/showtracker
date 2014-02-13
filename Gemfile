source 'https://rubygems.org'

ruby '2.1.0'

gem 'sinatra',         '~> 1.4.4', require: 'sinatra/base'
gem 'sinatra-contrib', '~> 1.4.2'
gem 'sequel',          '~> 4.7.0'
gem 'sass',            '~> 3.2.14'

group :development do
  gem 'sqlite3', '~>1.3', require: false
  gem 'awesome_print',    require: false
  gem 'rerun',            require: false
  gem 'pry',              require: false
end

group :test do
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
end

group :production do
  gem 'pg', require: false
end
