module ShowTracker
  # Networks Controller - all routes concerning Networks
  class NetworksController < Base
    NAMESPACE = '/networks'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers ShowHelpers
    helpers PagingHelpers

    get '/:network_id', '/:network_id/page/:page/?', integer?: :network_id do
      @network = Network.with_id params[:network_id]
      redirect '/', error: t('errors.no_such_network') if @network.nil?

      items_per_page = 12

      dataset = join_networks(Show, @network.id).order_by(Sequel.desc(:rating_count))
      dataset = select_all_shows(dataset)
      initialize_paging_properties(items_per_page, dataset.count)

      @shows = dataset.limit(items_per_page, @offset).all

      @url = "#{NAMESPACE}/#{@network.id}/"
      @title = @network.name
      @subtitle = "(#{t('general.network')})"
      erb :'networks/view'
    end
  end
end
