module ShowTracker
  class Base < Sinatra::Base
    use Sass::Plugin::Rack
    use Rack::Flash

    register Sinatra::Partial
    register Sinatra::ConfigFile

    helpers Sinatra::RedirectWithFlash

    config_file 'config/config.yml'

    enable :sessions
    set :session_secret, '51dd40e6847a1a6b31b75faf8f983721'
    set :environment, settings.environment

    set :views,         File.expand_path(settings.views_path)
    set :public_folder, File.expand_path(settings.public_path)
    set :partial_template_engine, :erb

    Bundler.require settings.environment

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

    register do
      def auth(type)
        condition do
          unless send "#{type}?"
            flash[:info] = 'You need to be logged in to access this page.'
            redirect "/auth/login"
          end
        end
      end
    end

    not_found do
      erb "oops"
    end
  end
end
