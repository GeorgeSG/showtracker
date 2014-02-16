module ShowTracker
  class GenresController < Base
    NAMESPACE = '/genres'.freeze

    helpers UserHelpers

    get '/:genre_id' do
      @genre = Genre.where(id: params[:genre_id]).first
      redirect '/', error: 'There is no such genre in our database' if @genre.nil?

      @title = @genre.name + ' :: Genre'
      erb :'genres/view'
    end
  end
end
