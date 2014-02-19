require_relative '../spec_helper'

describe 'Home Controller' do
  include Rack::Test::Methods

  def app
    ShowTracker::HomeController
  end

  # it 'loads index page' do
  #   get '/'
  #   expect(last_response).to be_ok
  # end

  # it '404s' do
  #   get '/asdasd'
  #   expect(last_response).to not_be_ok
  # end
end
