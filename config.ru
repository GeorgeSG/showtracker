require 'rubygems'
require 'bundler/setup'
Bundler.require :default

require './base'

controllers = File.join('./', 'controllers ** *_controller.rb')
Dir.glob(controllers).each {|file| require file }

controllers = [ShowTracker::MainController]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
