module ShowTracker
  class UsersController < Base
    NAMESPACE = '/users'.freeze

    helpers UserHelpers

    get '/add-show/:show_id' do
      redirect '/login', info: 'You must login to add show to your shows!' unless logged?

      show = Show.where(id: params[:show_id]).first
      redirect '/', error: 'There is no such show in our database!' if show.nil?

      usershow = UserShow.new
      usershow.user = current_user
      usershow.show = show
      usershow.save

      redirect '/users/my-shows', success: "You\'ve successfully added #{@show.name} to your shows!"
    end
  end
end
