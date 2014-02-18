module ShowTracker
  class GenresController < Base
    NAMESPACE = '/genres'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/:genre_id' do
      @genre = Genre.with_id params[:genre_id]
      redirect '/', error: t('errors.no_such_genre') if @genre.nil?

      @title = @genre.name
      erb :'genres/view'
    end
  end
end
