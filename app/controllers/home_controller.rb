class HomeController < ApplicationController
  def index
    @shows = Show.top_rated
  end
end
