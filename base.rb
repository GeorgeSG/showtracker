module ShowTracker
  class Base < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config/config.yml'

    enable :sessions
  end
end
