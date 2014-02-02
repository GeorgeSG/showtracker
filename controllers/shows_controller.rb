module ShowTracker
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze
    set :views, settings.views + NAMESPACE

    get '/' do
      @shows = Show.all
      erb :index
    end
  end
end
