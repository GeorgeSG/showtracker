require 'rubygems'
require 'bundler/setup'
Bundler.require :default

# =============================================================================
# Require all constants, models, controllers, helpers, etc
# =============================================================================
require_file = -> (file) { require file }

# These need to be required before the base class, because
# the base class must register all extensions
Dir.glob('./extensions/**/*.rb').each(&require_file)

require_relative '../base'

# These need to be required after the base class, because
# the database connection needs to be set up first
Dir.glob('./{models,helpers}/**/*.rb').each(&require_file)
Dir.glob('./controllers/**/*.rb').each(&require_file)
