module ShowTracker
  class ActorsController < Base
    NAMESPACE = '/actors'.freeze

    helpers UserHelpers

    get '/:actor_id' do
      @actor = Actor.where(id: params[:actor_id]).first
      redirect '/', error: 'There is no such actor in our database' if @actor.nil?

      @title = @actor.name + ' :: Actor'
      erb :'actors/view'
    end
  end
end
