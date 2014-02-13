module ShowTracker
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze

    get '/' do
      @shows = Show.all
      erb :'shows/index'
    end
  end
end
