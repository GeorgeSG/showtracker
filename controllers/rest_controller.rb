module ShowTracker
  class RESTController < Base
    require './core/api_result.rb'

    NAMESPACE = '/api'.freeze

    before do
      content_type :json
    end

    get '/add-show/:show_id' do

      # show = Show.with_id params[:show_id]
      # redirect '/', error: t('errors.no_such_show') if show.nil?

      # Usershow.create(user_id: current_user.id, show_id: show.id)

      {success: true}.to_json
    end
  end
end
