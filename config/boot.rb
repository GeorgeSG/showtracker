require 'rubygems'
require 'bundler/setup'
Bundler.require :default
require 'sass/plugin/rack'

#===============================================================================
# Require all constants, models, controllers, helpers, etc
#===============================================================================
require_file = -> (file) { require file }
Dir.glob('./extensions/**/*.rb').each(&require_file)

require_relative '../base'

# These need to be required after the base class, because
# the database connection needs to be set up first
Dir.glob('./{models,helpers}/**/*.rb').each(&require_file)
Dir.glob('./controllers/**/*.rb').each(&require_file)

