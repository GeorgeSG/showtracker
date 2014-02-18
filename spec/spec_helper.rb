ENV['RACK_ENV'] = 'test'

require_relative '../app/boot.rb'
Bundler.require :test

Dir['./spec/factories/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
