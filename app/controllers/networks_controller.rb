module ShowTracker
  # Networks Controller - all routes concerning Networks
  class NetworksController < Base
    NAMESPACE = '/networks'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers ShowHelpers
    helpers PagingHelpers

    before do
      @background = random_fanart
    end

    get '/:network_id', '/:network_id/page/:page/?', integer?: :network_id do
      @network = Network.with_id params[:network_id]
      redirect '/', error: t('errors.no_such_network') if @network.nil?

      select_cards_for_object(@network)

      @paging_url = "#{NAMESPACE}/#{@network.id}/"
      @title = @network.name
      @subtitle = "(#{t('general.network')})"
      erb :'networks/view'
    end
  end
end
