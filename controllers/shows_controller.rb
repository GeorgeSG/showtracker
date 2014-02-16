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
      @shows = Show.all
      erb :'shows/all'
    end

    get '/search' do
      @title = 'Search Results'

      @api_results = TVDB.series.search(params[:q]).map do |serie|
        TVDB.series.find(serie.api_id)
      end

      erb :'shows/search'
    end

    get '/add/:series_id' do
      series_id = params[:series_id]
      serie     = TVDB.series.find(series_id)
      p serie
    end

    get '/my-shows', auth: :logged do
      erb :'shows/my-shows'
    end
  end
end
