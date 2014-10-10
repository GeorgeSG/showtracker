require 'rubygems'
require 'yaml'
require 'bundler/setup'
Bundler.require :default

# Main Application module
module ShowTracker
  CONFIG_PATH = 'config/config.yml'.freeze
end

# =============================================================================
# Require all constants, models, controllers, helpers, etc
# =============================================================================

config_file = File.expand_path('../' + ShowTracker::CONFIG_PATH, __FILE__)
config_file = File.open(config_file)
settings    = YAML.load(config_file)
app_path    = settings['app_path'] || './'

require_file = -> (file) { require file }

# These need to be required before the base class, because
# the base class must register all extensions.
Dir[app_path + '/extensions/**/*.rb'].each(&require_file)
Dir[app_path + '/base.rb'].each(&require_file)

# These need to be required after the base class, because
# the database connection needs to be set up first, and
# also the base class must be defined to subclass it.
Dir[app_path + '/{models,helpers,controllers}/**/*.rb'].each(&require_file)
