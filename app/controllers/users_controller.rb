module ShowTracker
  # Users Controller - All routes handling user interactions and pages
  class UsersController < Base
    NAMESPACE = '/users'.freeze

    helpers UserHelpers
    helpers HTMLHelpers
    helpers UsershowHelpers

    get '/my-shows', auth: :logged do
      @usershows = current_user.usershows.sort
      @title = t('general.my_shows')
      erb :'users/my-shows'
    end

    get '/add-show/:show_id', auth: :logged, integer?: :show_id do
      show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if show.nil?

      add_show(current_user.id, show.id)

      flash[:success] = t('successes.added_show', name: show.name)
      redirect NAMESPACE + '/my-shows'
    end

    get '/remove-show/:show_id', auth: :logged, integer?: :show_id do
      show = Show.with_id params[:show_id]
      redirect '/', error: t('errors.no_such_show') if show.nil?
      remove_show(current_user.id, show.id)

      flash[:success] = t('successes.removed_show', name: show.name)
      redirect NAMESPACE + '/my-shows'
    end

    get '/decrement-episode/:usershow_id', auth: :logged, integer?: :usershow_id do
      usershow = Usershow.with_id params[:usershow_id]
      decrement_episode(usershow)

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
      increment_episode(usershow)

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
      decrement_season(usershow)

      flash[:success] = t(
        'successes.season_unwatched',
        season: usershow.season + 1,
        show: usershow.show.name
      )

      redirect NAMESPACE + '/my-shows'
    end

    get '/increment-season/:usershow_id', auth: :logged, integer?: :usershow_id do
      usershow = Usershow.with_id params[:usershow_id]
      increment_season(usershow)

      flash[:success] = t(
        'successes.season_watched',
        season: usershow.season - 1,
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
      login username, password
    end

    get '/logout', auth: :logged do
      logout
    end

    post '/signup' do
      username         = params[:username]
      password         = params[:password]
      confirm_password = params[:confirm_password]
      email            = params[:email]
      first_name       = params[:first_name]
      last_name        = params[:last_name]
      signup username, password, confirm_password, email, first_name, last_name
    end
  end
end
