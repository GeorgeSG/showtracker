class ShowsController < ApplicationController
  def index

  end

  def show
    @show = Show.find_by_id(params[:id])
  end
end
