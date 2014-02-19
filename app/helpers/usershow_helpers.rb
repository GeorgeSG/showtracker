module ShowTracker
  module UsershowHelpers
    def add_show(user_id, show_id)
      Usershow.create(user_id: user_id, show_id: show_id)
    end

    def remove_show(user_id, show_id)
      usershow = Usershow.for user: user_id, and_show: show_id

      if usershow.nil?
        flash[:error] = t('errors.not_in_my_shows')
        redirect NAMESPACE + '/my-shows'
      end

      usershow.destroy
    end

    def decrement_season(usershow)
      if usershow.season.nil? || usershow.season.zero?
        redirect NAMESPACE + '/my-shows', error: t('errors.no_seasons_yet')
      end

      usershow.decrement_season
      usershow.save
    end

    def increment_season(usershow)
      usershow.increment_season
      usershow.save
    end

    def increment_episode(usershow)
      if usershow.season_watched?
        flash[:error] = 'There are no more episodes in this season!'
        redirect NAMESPACE + '/my-shows'
      end

      usershow.increment_episode
      usershow.save
    end

    def decrement_episode(usershow)
      if usershow.episode.zero? || usershow.episode.nil?
        flash[:error] = 'You haven\'t watched any episodes yet!'
        redirect NAMESPACE + '/my-shows'
      end

      usershow.decrement_episode
      usershow.save
    end
  end
end
