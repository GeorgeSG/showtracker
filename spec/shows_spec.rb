require './spec_helper'

def app
  MainController
end

describe 'Main Controller' do
  include Rack::Test::Methods

  def app
    MainController
  end

  it 'loads index page' do
    get '/'
    last_response.should be_ok
  end
end
