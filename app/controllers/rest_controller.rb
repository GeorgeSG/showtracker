require_relative '../../lib/api_response.rb'

module ShowTracker
  # REST Controller - provides routes for API access
  class RESTController < Base
    NAMESPACE = '/api'.freeze
    RESPONSE_OK = APIResponse.new.response.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    before do
      content_type :json
    end

    get '/increment-episode/:user_id/:show_id/?' do
      user_id, show_id = params[:user_id], params[:show_id]
      usershow = Usershow.for user: user_id, and_show: show_id

      if usershow.nil?
        result = APIResponse.new(400, 'There is no such show for that user!')
        return result.response
      end

      usershow.increment_episode
      usershow.save

      RESPONSE_OK
    end

    get '/decrement-episode/:user_id/:show_id/?' do
      user_id, show_id = params[:user_id], params[:show_id]
      usershow = Usershow.for user: user_id, and_show: show_id

      if usershow.nil?
        result = APIResponse.new(400, 'There is no such show for that user!')
        return result.response
      end

      usershow.decrement_episode
      usershow.save

      RESPONSE_OK
    end

    get '/increment-season/:user_id/show_id/?' do
      user_id, show_id = params[:user_id], params[:show_id]
      usershow = Usershow.for user: user_id, and_show: show_id

      if usershow.nil?
        result = APIResponse.new(400, 'There is no such show for that user!')
        return result.response
      end

      usershow.increment_season
      usershow.save

      RESPONSE_OK
    end

    get '/decrement-season/:user_id/show_id/?' do
      user_id, show_id = params[:user_id], params[:show_id]
      usershow = Usershow.for user: user_id, and_show: show_id

      if usershow.nil?
        result = APIResponse.new(400, 'There is no such show for that user!')
        return result.response
      end

      usershow.decrement_season
      usershow.save

      RESPONSE_OK
    end
  end
end
