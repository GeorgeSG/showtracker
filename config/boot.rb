require 'rubygems'
require 'bundler/setup'
Bundler.require :default
require 'sass/plugin/rack'

# use scss for stylesheets
Sass::Plugin.options[:style] = :compressed

#===============================================================================
# Require all constants, models, controllers and helpers
#===============================================================================
require_file = -> (file) { require file }
Dir.glob('./extensions/**/*.rb').each(&require_file)

require_relative '../base'

# These need to be required after the base class, because
# the database connection needs to be set up first
Dir.glob('./{models,helpers}/**/*.rb').each(&require_file)
Dir.glob('./controllers/**/*.rb').each(&require_file)

