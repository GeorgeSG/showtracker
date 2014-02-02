require 'rubygems'
require 'bundler/setup'
Bundler.require :default

#===============================================================================
# Require all constants, models, controllers and helpers
#===============================================================================

require './base'

require_file = -> (file) { require file }
Dir.glob('./{models,helpers}/**/*.rb').each(&require_file)
Dir.glob('./controllers/**/*.rb').each(&require_file)

#===============================================================================
# Map Top Level Controllers
#===============================================================================

controllers = [
  ShowTracker::MainController,
  ShowTracker::ShowsController
]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
