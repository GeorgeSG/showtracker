class ActorsController < ApplicationController
  def show
    @shows = Actor.find_by_id(params[:id]).shows
  end
end
