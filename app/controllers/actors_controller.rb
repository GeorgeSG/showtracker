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

      select_cards_for_object(@actor)

      @paging_url = "#{NAMESPACE}/#{@actor.id}/"
      @title = @actor.name
      @subtitle = "(#{t('general.actor')})"
      erb :'actors/view'
    end
  end
end
