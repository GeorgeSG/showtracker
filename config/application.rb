require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Showtracker
  class Application < Rails::Application
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

    config.generators do |g|
      g.test_framework :rspec

      g.factory_girl dir: 'spec/support/factories'
    end
  end
end
