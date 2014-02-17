module ShowTracker
  class UsersController < Base
    NAMESPACE = '/users'.freeze

    helpers UserHelpers
    helpers HTMLHelpers

    get '/my-shows', auth: :logged do
      @usershows = current_user.usershows.sort
      @title = t('general.my_shows')
      erb :'users/my-shows'
    end

    get '/add-show/:show_id', auth: :logged do
      show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if show.nil?

      Usershow.create(user_id: current_user.id, show_id: show.id)

      flash[:success] = t('successes.added_show', name: show.name)
      redirect '/users/my-shows'
    end

    get '/remove-show/:show_id', auth: :logged do
      show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if show.nil?

      usershow = Usershow.for_user_and_show current_user.id, show.id
      redirect '/users/my-shows', error: t('errors.not_in_my_shows') if usershow.nil?

      usershow.destroy

      redirect '/users/my-shows', success: t('successes.removed_show', name: show.name)
    end

    get '/decrement-episode/:usershow_id', auth: :logged do
      usershow = Usershow.with_id params[:usershow_id]

      if usershow.episode.zero? || usershow.episode.nil?
        redirect '/users/my-shows', error: 'You haven\'t watched any episodes yet!'
      end

      usershow.decrement_episode
      usershow.save

      flash[:success] = t('successes.episode_unwatched', season: usershow.season,
                                                        episode: usershow.episode + 1,
                                                           show: usershow.show.name)

      redirect '/users/my-shows'
    end

    get '/increment-episode/:usershow_id', auth: :logged do
      usershow = Usershow.with_id params[:usershow_id]
      usershow.increment_episode
      usershow.save

      flash[:success] = t('successes.episode_watched', season: usershow.season,
                                                      episode: usershow.episode,
                                                         show: usershow.show.name)
      redirect '/users/my-shows'
    end

    get '/decrement-season/:usershow_id', auth: :logged do
      usershow = Usershow.with_id params[:usershow_id]

      if usershow.season.nil? || usershow.season.zero?
        redirect '/users/my-shows', error: t('errors.no_seasons_yet')
      end

      usershow.decrement_season
      usershow.save

      flash[:success] = t('successes.season_unwatched', season: usershow.season + 1,
                                                          show: usershow.show.name)
      redirect '/users/my-shows'
    end

    get '/increment-season/:usershow_id', auth: :logged do
      usershow = Usershow.with_id params[:usershow_id]
      usershow.increment_season
      usershow.save

      flash[:success] = t('successes.season_watched', season: usershow.season,
                                                        show: usershow.show.name)
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
        redirect NAMESPACE + '/login', error: t('errors.no_such_user')
      end

      password = hash_password(password, user.salt)
      if password != user.password
        redirect NAMESPACE + '/login', error: t('errors.incorrect_password')
      end

      session[:uid] = user.id
      redirect '/', success: t('successes.welcome', name: user.username)
    end

    get '/logout', auth: :logged do
      session[:uid] = nil
      redirect '/', success: t('successes.logout')
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

      flash[:success] = t('successes.register')
      redirect NAMESPACE + '/login'
    end
  end
end
