class ShowsController < ApplicationController
  def index
    page = params[:page] || 1

    if params[:name]
      @shows = Show.with_name_like(params[:name]).page(page)
    else
      @shows = Show.page(page)
    end
  end

  def show
    @show = Show.find_by_id(params[:id])
  end
end
