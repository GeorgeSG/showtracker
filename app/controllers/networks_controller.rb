class NetworksController < ApplicationController
  def show
    @shows = Network.find_by_id(params[:id]).shows
  end
end
