module ShowTracker
  # Home Controller - for all general purpose routes that should not be in
  # any other controller
  class HomeController < Base
    NAMESPACE = '/'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/' do
      erb :'home/index'
    end
  end
end
