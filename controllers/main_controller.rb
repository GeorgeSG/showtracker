module ShowTracker
  class MainController < Base
    NAMESPACE = '/'.freeze
    set :views, settings.views + '/home'

    get '/' do
      erb :index
    end
  end
end
