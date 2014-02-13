require 'rubygems'
require 'bundler/setup'
Bundler.require :default
require 'sass/plugin/rack'

# use scss for stylesheets
Sass::Plugin.options[:style] = :compressed

#===============================================================================
# Require all constants, models, controllers and helpers
#===============================================================================
require_relative '../base'

require_file = -> (file) { require file }
Dir.glob('./{models,helpers}/**/*.rb').each(&require_file)
Dir.glob('./controllers/**/*.rb').each(&require_file)

