module ShowTracker
  class MainController < Base
    NAMESPACE = '/'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/' do
      erb :'home/index'
    end
  end
end
