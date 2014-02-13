module ShowTracker
  class MainController < Base
    NAMESPACE = '/'.freeze

    get '/' do
      erb :'home/index'
    end
  end
end
