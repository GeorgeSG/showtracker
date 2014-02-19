module ShowTracker
  # Genres Controller - all routes concerning Genres
  class GenresController < Base
    NAMESPACE = '/genres'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers ShowHelpers
    helpers PagingHelpers

    get '/:genre_id', '/:genre_id/page/:page/?', integer?: :genre_id do
      @genre = Genre.with_id params[:genre_id]
      redirect '/', error: t('errors.no_such_genre') if @genre.nil?

      select_cards_for_object(@genre)

      @paging_url = "#{NAMESPACE}/#{@genre.id}/"
      @title = @genre.name
      @subtitle = "(#{t('general.genre')})"
      erb :'genres/view'
    end
  end
end
