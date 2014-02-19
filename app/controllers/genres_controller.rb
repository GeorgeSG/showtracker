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

      items_per_page = 12

      dataset = join_genres(Show, @genre.id).order_by(Sequel.desc(:rating_count))
      dataset = select_all_shows(dataset)
      initialize_paging_properties(items_per_page, dataset.count)

      @shows = dataset.limit(items_per_page, @offset).all

      @url = "#{NAMESPACE}/#{@genre.id}/"
      @title = @genre.name
      @subtitle = "(#{t('general.genre')})"
      erb :'genres/view'
    end
  end
end
