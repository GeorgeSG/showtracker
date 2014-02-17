module ShowTracker
  class GenresController < Base
    NAMESPACE = '/genres'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/:genre_id' do
      @genre = Genre.with_id params[:genre_id]
      redirect '/', error: 'There is no such genre in our database' if @genre.nil?

      @title = @genre.name + ' :: Genre'
      erb :'genres/view'
    end
  end
end
