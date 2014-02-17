module ShowTracker

  class UsersController < Base
    NAMESPACE = '/users'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/my-shows', auth: :logged do
      @usershows = current_user.usershows.sort
      @title = 'My Shows'
      erb :'users/my-shows'
    end

    get '/add-show/:show_id', auth: :logged do
      show = Show.where(id: params[:show_id]).first
      redirect '/', error: 'There is no such show in our database!' if show.nil?

      Usershow.create(user_id: current_user.id, show_id: show.id)

      flash[:success] = "You've successfully added #{show.name} to your shows!"
      redirect '/users/my-shows'
    end

    get '/remove-show/:show_id', auth: :logged do
      show = Show.with_id params[:show_id]
      redirect '/', error: 'There is no such show in our database!' if show.nil?

      usershow = Usershow.for_user_and_show current_user.id, show.id
      redirect '/users/my-shows', error: "You don't have that show in your shows!" if usershow.nil?

      usershow.destroy

      redirect '/users/my-shows', success: "You\'ve successfully removed #{show.name} to your shows!"
    end

    get '/decrement-episode/:usershow_id' do
      usershow = Usershow.with_id params[:usershow_id]

      if usershow.episode.zero? || usershow.episode.nil?
        redirect '/users/my-shows', error: 'You haven\'t watched any episodes yet!'
      end

      usershow.decrement_episode
      usershow.save

      message = "You've successfully marked Season #{usershow.season} Episode #{usershow.episode + 1} of #{usershow.show.name} as unwatched!"
      redirect '/users/my-shows', success: message
    end

    get '/increment-episode/:usershow_id' do
      usershow = Usershow.with_id params[:usershow_id]
      usershow.increment_episode
      usershow.save

      flash[:success] = "You've successfully marked Season #{usershow.season} Episode #{usershow.episode} of #{usershow.show.name} as watched!"
      redirect '/users/my-shows'
    end

    get '/decrement-season/:usershow_id' do
      usershow = Usershow.with_id params[:usershow_id]

      if usershow.season.nil? || usershow.season.zero?
        redirect '/users/my-shows', error: 'You haven\'t watched any seasons yet!'
      end

      usershow.decrement_season
      usershow.save

      flash[:success] = "You've successfully marked Season #{usershow.season + 1} of #{usershow.show.name} as unwatched!"
      redirect '/users/my-shows'
    end

    get '/increment-season/:usershow_id' do
      usershow = Usershow.with_id params[:usershow_id]
      usershow.increment_season
      usershow.save

      flash[:success] = "You've successfully marked Season #{usershow.season} of #{usershow.show.name} as watched!"
      redirect '/users/my-shows'
    end

    get '/login' do
      redirect '/user/profile' if logged?
      erb :'users/login'
    end

    post '/login' do
      username = params[:username]
      password = params[:password]

      user = User.find(username: username)

      if user.nil?
        redirect NAMESPACE + '/login', error: 'There is no such user in our database!'
      end

      password = hash_password(password, user.salt)
      if password != user.password
        redirect NAMESPACE + '/login', error: 'You\'ve entered an incorrect password!'
      end

      session[:uid] = user.id
      redirect '/', success: "Welcome, #{user.username}! Enjoy your stay!"
    end

    get '/logout' do
      redirect '/users/login' unless logged?

      session[:uid] = nil
      redirect '/', success: 'You\'ve logged out successfully! Have a nice day!'
    end

    post '/signup' do
      username         = params[:username]
      password         = params[:password]
      confirm_password = params[:confirm_password]
      email            = params[:email]
      first_name       = params[:first_name]
      last_name        = params[:last_name]

      password_salt = hash_salt
      password_hash = hash_pasword(params[:password], password_salt)

      user = User.create(username: username,
                         password: password_hash,
                         salt: password_salt,
                         email: email,
                         first_name: first_name,
                         last_name: last_name)

      flash[:success] = 'You have registered succesfully!'
      redirect NAMESPACE + '/login'
    end
  end
end
