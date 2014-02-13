require_relative '../config/boot.rb'
Bundler.require :test

ENV['RACK_ENV'] = "test"

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
