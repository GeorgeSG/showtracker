class ActorsController < ApplicationController
  def show
    page = params[:page] || 1
    @shows = Actor.find_by_id(params[:id]).shows.page(page)
  end
end
