module ShowTracker
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze

    helpers UserHelpers

    get '/' do
      @title = 'Featured Shows'
      @shows = Show.all
      erb :'shows/index'
    end

    get '/all' do
      @title = 'All Shows'
      erb :'shows/all'
    end

    get '/search' do
      @title = 'Search Results'
      erb :'shows/search'
    end

    get '/my-shows', auth: :logged do
      erb :'shows/my-shows'
    end
  end
end
