module ShowTracker
  class Base < Sinatra::Base
    use Sass::Plugin::Rack
    use Rack::Flash

    register Sinatra::Partial
    register Sinatra::ConfigFile
    register Sinatra::MultiRoute
    register Sinatra::I18nSupport
    register ShowTracker::AuthorizationChecker

    helpers Sinatra::RedirectWithFlash

    config_file 'config/config.yml'
    environment = settings.environment
    env_settings = settings.send environment

    enable :sessions
    set :session_secret, '51dd40e6847a1a6b31b75faf8f983721'
    set :environment, environment

    set :views,         File.expand_path(settings.views_path)
    set :public_folder, File.expand_path(settings.public_path)
    set :partial_template_engine, :erb

    load_locales settings.locales_path

    Bundler.require environment

    db_host     = env_settings['db_host']
    db_name     = env_settings['db_name']
    db_user     = env_settings['db_user']
    db_password = env_settings['db_password']

    DB = Sequel.postgres(db_name, host: db_host, user: db_user, password: db_password)

    configure :production do
      disable :show_exceptions
    end

    not_found do
      erb "oops"
    end
  end
end
