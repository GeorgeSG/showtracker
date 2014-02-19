module ShowTracker
  # Home Controller - for all general purpose routes that should not be in
  # any other controller
  class HomeController < Base
    NAMESPACE = '/'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/' do
      @shows = Show.order_by(Sequel.desc(:rating_count)).limit(10).all
      erb :'home/index'
    end
  end
end
