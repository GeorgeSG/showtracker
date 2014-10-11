class GenresController < ApplicationController
  def show
    @shows = Genre.find_by_id(params[:id]).shows
  end
end
