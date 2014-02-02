require 'rubygems'
require 'bundler/setup'
Bundler.require :default

#===============================================================================
# Require all constants, models, controllers and helpers
#===============================================================================

require_relative './base'

require_file = -> (file) { require file }
Dir.glob('./{models,helpers}/**/*.rb').each(&require_file)
Dir.glob('./controllers/**/*.rb').each(&require_file)

