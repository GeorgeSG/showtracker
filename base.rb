module ShowTracker
  class Base < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config/config.yml'

    enable :sessions
    set :environment, settings.environment

    set :views,         File.expand_path(settings.views_path,  __FILE__)
    set :public_folder, File.expand_path(settings.public_path, __FILE__)

    configure :development do
      DB = Sequel.sqlite settings.development[:sqlite_path]
    end

    configure :production do
      disable :show_exceptions

      db_host     = settings.production['db_host']
      db_name     = settings.production['db_name']
      db_user     = settings.production['db_user']
      db_password = settings.production['db_password']

      DB = Sequel.postgres(db_name,
                           host: db_host,
                           user: db_user,
                           password: db_password)
    end
  end
end
