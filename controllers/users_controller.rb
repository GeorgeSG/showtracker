module ShowTracker

  class UsersController < Base
    NAMESPACE = '/users'.freeze

    helpers UserHelpers

    get '/my-shows', auth: :logged do
      @usershows = current_user.usershows.sort do |first, second|
        first.show.name <=> second.show.name
      end

      @title = 'My Shows'
      erb :'users/my-shows'
    end

    get '/add-show/:show_id', auth: :logged do
      show = Show.where(id: params[:show_id]).first
      redirect '/', error: 'There is no such show in our database!' if show.nil?

      usershow = Usershow.new
      usershow.user = current_user
      usershow.show = show
      usershow.save

      redirect '/users/my-shows', success: "You\'ve successfully added #{show.name} to your shows!"
    end

    get '/remove-show/:show_id', auth: :logged do
      show = Show.where(id: params[:show_id]).first
      redirect '/', error: 'There is no such show in our database!' if show.nil?

      usershow = Usershow.where(user_id: current_user.id, show_id: show.id).first
      redirect '/users/my-shows', error: "You don't have that show in your shows!" if usershow.nil?

      usershow.delete

      redirect '/users/my-shows', success: "You\'ve successfully removed #{show.name} to your shows!"
    end

    get '/decrement-episode/:usershow_id' do
      usershow = Usershow.where(id: params[:usershow_id]).first

      usershow.season = 1 if usershow.season.nil? || usershow.season.zero?

      if usershow.episode.zero? || usershow.episode.nil?
        redirect '/users/my-shows', error: 'You haven\'t watched any episodes yet!'
      end
      old_episode = usershow.episode || 1

      unless usershow.episode.nil? or usershow.episode.zero?
        usershow.episode -= 1
        usershow.save
      end

      message = "You've successfully marked Season #{usershow.season} Episode #{old_episode} of #{usershow.show.name} as unwatched!"
      redirect '/users/my-shows', success: message
    end

    get '/increment-episode/:usershow_id' do
      usershow = Usershow.where(id: params[:usershow_id]).first

      usershow.season = 1 if usershow.season.nil? || usershow.season.zero?

      if usershow.episode.nil?
        usershow.episode = 1
      else
        usershow.episode += 1
      end
      usershow.save

      message = "You've successfully marked Season #{usershow.season} Episode #{usershow.episode} of #{usershow.show.name} as watched!"
      redirect '/users/my-shows', success: message
    end

    get '/decrement-season/:usershow_id' do
      usershow = Usershow.where(id: params[:usershow_id]).first

      if usershow.season.zero? || usershow.season.nil?
        redirect '/users/my-shows', error: 'You haven\'t watched any seasons yet!'
      end

      old_season = usershow.season || 1

      usershow.episode = 0

      unless usershow.season.nil? or usershow.season.zero?
        usershow.season -= 1
        usershow.save
      end

      message = "You've successfully marked Season #{old_season} of #{usershow.show.name} as unwatched!"
      redirect '/users/my-shows', success: message
    end

    get '/increment-season/:usershow_id' do
      usershow = Usershow.where(id: params[:usershow_id]).first

      usershow.episode = 0

      if usershow.season.nil?
        usershow.season = 1
      else
        usershow.season += 1
      end
      usershow.save

      message = "You've successfully marked Season #{usershow.season} of #{usershow.show.name} as watched!"
      redirect '/users/my-shows', success: message
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

      password = BCrypt::Engine.hash_secret(password, user.salt)
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

      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

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
