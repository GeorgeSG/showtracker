module ShowTracker
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze

    helpers UserHelpers

    get '/' do
      @shows = Show.all
      erb :'shows/index'
    end

    get '/my-shows', auth: :logged do
      erb :'shows/my-shows'
    end
  end
end
