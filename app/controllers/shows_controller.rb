module ShowTracker
  # Shows Controller - All routes handling Show interaction
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers PagingHelpers

    get '/', '/page/:page/?' do
      ITEMS_PER_PAGE = 12

      @query = params[:q] || ''

      criteria = Show.search_for(@query)
      initialize_paging_properties(ITEMS_PER_PAGE, criteria.count)

      @shows = criteria.order_by(Sequel.desc(:rating_count))
      @shows = @shows.limit(ITEMS_PER_PAGE, @offset).all

      @url = NAMESPACE + '/'

      @title = t('general.shows')
      erb :'shows/index'
    end

    get '/list', '/list/page/:page/?', '/search', '/search/page/:page/?' do
      ITEMS_PER_PAGE = 30

      @query = params[:q] || ''

      criteria = Show.search_for(@query)
      initialize_paging_properties(ITEMS_PER_PAGE, criteria.count)

      @shows = criteria.order_by(:name).limit(ITEMS_PER_PAGE, @offset).all
      @shows = @shows.group_by { |show| show.name[0] }

      if request.path_info.match(/list/)
        @title = t('general.shows')
        @url = NAMESPACE + '/list/'
      else
        @title = t('general.results')
        @subtitle = "(#{criteria.count})"
        @url = NAMESPACE + '/search/'
      end

      erb :'shows/search'
    end

    get '/:show_id' do
      @show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if @show.nil?

      if logged?
        @usershow = Usershow.for_user_and_show(current_user.id, @show.id)
      end

      @title = @show.name
      erb :'shows/view'
    end
  end
end
