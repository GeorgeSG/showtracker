module ShowTracker
  class MainController < Base
    configure do
      NAMESPACE = '/'.freeze
      set :views, settings.views + '/home'
    end

    get '/' do
      erb :index
    end
  end
end
