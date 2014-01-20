module ShowTracker
  class MainController < Base
    NAMESPACE = '/'.freeze

    get '/' do
      erb 'hello world'
    end

    get '/test' do
      erb 'hello test'
    end

  end
end
