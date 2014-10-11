class GenresController < ApplicationController
  def show
    page = params[:page] || 1
    @shows = Genre.find_by_id(params[:id]).shows.page(page)
  end
end
