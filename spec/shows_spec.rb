require './spec_helper'

describe ShowTracker::ShowsController do
  describe 'GET /' do
    it 'should be successful' do
      get '/'
      last_response.should be_ok
    end
  end
end
