module ShowTracker
  # Actors Controller - all routes concerning Actors
  class ActorsController < Base
    NAMESPACE = '/actors'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers ShowHelpers
    helpers PagingHelpers

    get '/:actor_id', integer?: :actor_id do
      @actor = Actor.with_id params[:actor_id]
      redirect '/', error: t('errors.no_such_actors') if @actor.nil?

      items_per_page = 12

      dataset = join_actors(Show, @actor.id).order_by(Sequel.desc(:rating_count))
      dataset = select_all_shows(dataset)
      initialize_paging_properties(items_per_page, dataset.count)

      @shows = dataset.limit(items_per_page, @offset).all

      @url = "#{NAMESPACE}/#{@actor.id}/"
      @title = @actor.name
      @subtitle = "(#{t('general.actor')})"
      erb :'actors/view'
    end
  end
end
