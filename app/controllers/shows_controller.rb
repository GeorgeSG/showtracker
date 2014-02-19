module ShowTracker
  # Shows Controller - All routes handling Show interaction
  class ShowsController < Base
    NAMESPACE = '/shows'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers PagingHelpers
    helpers ShowHelpers

    before do
      @background = random_fanart
    end

    get '/', '/page/:page/?' do
      @name = params[:q] || ''

      select_cards_for_show(@name)

      @paging_url = NAMESPACE + '/'
      @title = t('general.shows')
      erb :'shows/index'
    end

    get '/list', '/list/page/:page/?' do
      items_per_page = 30
      @name = params[:q] || ''

      select_list_for_show(@name)

      @paging_url = NAMESPACE + '/list/'
      @title = t('general.shows')
      erb :'shows/list'
    end

    get '/search', '/search/page/:page/?' do
      items_per_page = 12
      name    = params[:name]
      actor   = params[:actor]
      genre   = params[:genre]
      network = params[:network]
      status  = params[:status]

      dataset = advanced_search_dataset(name, actor, genre, network, status)
      initialize_paging_properties(items_per_page, dataset.count)

      dataset = dataset.order_by(Sequel.desc(:shows__rating_count))
      @shows = dataset.limit(items_per_page, @offset).all

      @title = t('general.search')
      @subtitle = "(#{dataset.count})"
      @paging_url = NAMESPACE + '/search/'

      erb :'shows/search'
    end

    get '/:show_id' do
      @show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if @show.nil?

      Miro.options[:resolution] = '750x140'
      unless @show.banner.nil?
        colors = Miro::DominantColors.new("http://thetvdb.com/banners/#{@show.banner}")
        @color = colors.to_hex[0] rescue nil
      end

      if logged?
        @usershow = Usershow.for user: current_user.id, and_show: @show.id
      end

      @background = @show.fanart || @show.poster || random_fanart
      @title = @show.name
      erb :'shows/view'
    end
  end
end
