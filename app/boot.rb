require 'rubygems'
require 'bundler/setup'
require 'yaml'
Bundler.require :default

# =============================================================================
# Require all constants, models, controllers, helpers, etc
# =============================================================================

config_file  = File.open(File.expand_path('../config/config.yml', __FILE__))
settings     = YAML.load(config_file)
app_path     = settings['app_path'] || './'

require_file = lambda { |file| require file }

# These need to be required before the base class, because
# the base class must register all extensions
Dir.glob(app_path + '/extensions/**/*.rb').each &require_file
Dir.glob(app_path + '/base.rb').each &require_file

# These need to be required after the base class, because
# the database connection needs to be set up first, and
# also the base class must be defined to subclass it
Dir.glob(app_path + '/{models,helpers,controllers}/**/*.rb').each &require_file
