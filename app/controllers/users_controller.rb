module ShowTracker
  # Users Controller - All routes handling user interactions and pages
  class UsersController < Base
    NAMESPACE = '/users'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers ShowHelpers

    before do
      @background = random_fanart
    end

    get '/my-shows', auth: :logged do
      @usershows = current_user.usershows.sort

      shows = current_user.usershows.map(&:show)
      @background = shows.sample.fanart unless shows.empty?
      @title = t('general.my_shows')
      erb :'users/my-shows'
    end

    get '/add-show/:show_id', auth: :logged, integer?: :show_id do
      show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if show.nil?

      Usershow.create(user_id: current_user.id, show_id: show.id)

      flash[:success] = t('successes.added_show', name: show.name)
      redirect NAMESPACE + '/my-shows'
    end

    get '/remove-show/:show_id', auth: :logged, integer?: :show_id do
      show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if show.nil?
      usershow = Usershow.for user: current_user.id, and_show: show.id

      if usershow.nil?
        flash[:error] = t('errors.not_in_my_shows')
        redirect NAMESPACE + '/my-shows'
      end

      usershow.destroy
      flash[:success] = t('successes.removed_show', name: show.name)
      redirect NAMESPACE + '/my-shows'
    end

    get '/decrement-episode/:usershow_id', auth: :logged, integer?: :usershow_id do
      usershow = Usershow.with_id params[:usershow_id]
      if usershow.episode.zero? || usershow.episode.nil?
        flash[:error] = 'You haven\'t watched any episodes yet!'
        redirect NAMESPACE + '/my-shows'
      end

      usershow.decrement_episode
      usershow.save

      flash[:success] = t(
        'successes.episode_unwatched',
        season: usershow.season,
        episode: usershow.episode + 1,
        show: usershow.show.name
      )

      redirect NAMESPACE + '/my-shows'
    end

    get '/increment-episode/:usershow_id', auth: :logged, integer?: :usershow_id do
      usershow = Usershow.with_id params[:usershow_id]
      if usershow.season_watched?
        flash[:error] = 'There are no more episodes in this season!'
        redirect NAMESPACE + '/my-shows'
      end

      usershow.increment_episode
      usershow.save

      flash[:success] = t(
        'successes.episode_watched',
        season: usershow.season,
        episode: usershow.episode,
        show: usershow.show.name
      )

      redirect NAMESPACE + '/my-shows'
    end

    get '/decrement-season/:usershow_id', auth: :logged, integer?: :usershow_id do
      usershow = Usershow.with_id params[:usershow_id]
      if usershow.season.nil? || usershow.season.zero?
        redirect NAMESPACE + '/my-shows', error: t('errors.no_seasons_yet')
      end

      usershow.decrement_season
      usershow.save

      flash[:success] = t(
        'successes.season_unwatched',
        season: usershow.season + 1,
        show: usershow.show.name
      )

      redirect NAMESPACE + '/my-shows'
    end

    get '/increment-season/:usershow_id', auth: :logged, integer?: :usershow_id do
      usershow = Usershow.with_id params[:usershow_id]

      if usershow.season == usershow.show.seasons_count
        flash[:error] = 'This is the last season yet!'
        redirect NAMESPACE + '/my-shows'
      end

      usershow.increment_season
      usershow.save

      flash[:success] = t(
        'successes.season_watched',
        season: usershow.season,
        show: usershow.show.name
      )

      redirect NAMESPACE + '/my-shows'
    end

    get '/login' do
      redirect NAMESPACE + '/profile' if logged?
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
      logout
    end

    post '/signup' do
      username         = params[:username]
      password         = params[:password]
      confirm_password = params[:password_confirmed]
      email            = params[:email]
      first_name       = params[:first_name]
      last_name        = params[:last_name]
      unless password == confirm_password
        flash[:error] = 'The two passwords entered do not match!'
        redirect NAMESPACE + '/login'
      end

      password_salt = hash_salt
      password_hash = hash_password(password, password_salt)

      User.create(
        username: username,
        password: password_hash,
        salt: password_salt,
        email: email,
        first_name: first_name,
        last_name: last_name
      )

      redirect NAMESPACE + '/login', success: t('successes.register')
    end
  end
end
