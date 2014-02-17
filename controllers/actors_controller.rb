module ShowTracker
  class ActorsController < Base
    NAMESPACE = '/actors'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/:actor_id' do
      @actor = Actor.with_id params[:actor_id]
      redirect '/', error: 'There is no such actor in our database' if @actor.nil?

      @title = @actor.name + ' :: Actor'
      erb :'actors/view'
    end
  end
end
