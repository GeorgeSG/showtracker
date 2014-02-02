module ShowTracker
  class ShowsController < Base
    configure do
      NAMESPACE = '/shows'.freeze
      set :views, settings.views + NAMESPACE
    end

    get '/' do
      @shows = Show.all
      erb :index
    end
  end
end
