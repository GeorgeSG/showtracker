module ShowTracker
  class ActorsController < Base
    NAMESPACE = '/actors'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/:actor_id' do
      @actor = Actor.with_id params[:actor_id]
      redirect '/', error: t('errors.no_such_actors') if @actor.nil?

      @title = @actor.name
      erb :'actors/view'
    end
  end
end
