module ShowTracker
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers PagingHelpers

      get '/', '/page/:page' do
        ITEMS_PER_PAGE = 12

        @query = params[:q] || ''
        get_current_page

        criteria = Show.where("lower(name) like '%#{@query.downcase}%' AND NAME != ''")
        initialize_paging_properties(ITEMS_PER_PAGE, criteria.count)

        @shows = criteria.order_by(Sequel.desc(:rating_count)).limit(ITEMS_PER_PAGE, @offset).all
        @url = NAMESPACE + '/'

        @title = 'Shows'
        erb :'shows/index'
      end

      get '/list', '/list/page/:page', '/search', '/search/page/:page' do
        ITEMS_PER_PAGE = 30

        @query = params[:q] || ''
        get_current_page

        criteria = Show.where("lower(name) like '%#{@query.downcase}%' AND NAME != ''")
        initialize_paging_properties(ITEMS_PER_PAGE, criteria.count)

        @shows = criteria.order_by(:name).limit(ITEMS_PER_PAGE, @offset).all
        @shows = @shows.group_by { |show| show.name[0] }

        if request.path_info.match /list/
          @title = 'Shows'
          @url = NAMESPACE + '/list/'
        else
          @title = "Search Results"
          @subtitle = "(#{criteria.count})"
          @url = NAMESPACE + '/search/'
        end

        erb :'shows/search'
      end

    get '/:show_id' do
      @show = Show.where(id: params[:show_id]).first
      redirect '/', error: 'There is no such show in the database' if @show.nil?

      if logged?
        @usershow = Usershow.for_user_and_show(current_user.id, @show.id)
      end

      @title = @show.name
      erb :'shows/view'
    end
  end
end
