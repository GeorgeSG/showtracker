module ShowTracker
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze

    helpers UserHelpers

    get '/' do
      @title = 'Featured Shows'
      @shows = Show.order_by(Sequel.desc(:rating_count)).limit(12).all
      erb :'shows/index'
    end

    ['/all', '/all/:page', '/all/:page/', '/search', '/search/:page', '/search/:page/'].each do |route|
      get route do
        @query = params[:q] || ''
        @page  = params[:page].to_i
        @page  = 1 if @page < 1

        ITEMS_PER_PAGE = 30
        offset = ITEMS_PER_PAGE * (@page - 1)

        criteria = Show.where("lower(name) like '%#{@query.downcase}%' AND NAME != ''")
        @total_pages = criteria.count / ITEMS_PER_PAGE + 1

        @shows = criteria.order_by(:name).limit(ITEMS_PER_PAGE, offset).all
        @shows = @shows.group_by { |show| show.name[0] }

        if @total_pages < 5
          @start_page = 1
          @end_page = @total_pages
        elsif @page <= 2
          @start_page = 1
          @end_page = 5
        elsif @page >= (@total_pages - 2)
          @start_page = @total_pages - 4
          @end_page = @total_pages
        else
          @start_page = @page - 2
          @end_page = @page + 2
        end

        if route.match /all/
          @title = 'All Shows'
          @url = NAMESPACE + '/all/'
        else
          @title = "Search Results (<em>#{criteria.count}</em>)"
          @url = NAMESPACE + '/search/'
        end

        erb :'shows/search'
      end
    end

    get '/:show_id' do
      @show = Show.where(id: params[:show_id]).first
      redirect '/', error: 'There is no such show in the database' if @show.nil?

      if logged?
        @usershow = Usershow.where(user_id: current_user.id, show_id: @show.id).first
      end

      @title = @show.name
      erb :'shows/view'
    end
  end
end
