# Usershows Model
class Usershow < Sequel::Model
  many_to_one :show
  many_to_one :user

  def increment_season
    self.episode = 0
    self.season += 1
  end

  def decrement_season
    unless season.zero?
      self.episode = 0
      self.season -= 1
    end
  end

  def increment_episode
    self.season = 1 if season.zero?
    self.episode += 1
  end

  def decrement_episode
    self.episode -= 1 unless episode.zero?
  end

  def season_watched?
    episode >= show.episodes_for_season(season).size
  end

  def watched_episodes
    all_seasons = show.seasons.reject(&:zero?)
    episodes = all_seasons.reduce([]) do |episodes, season_number|
      if season > season_number
        episodes << show.episodes_for_season(season_number)
      end
      episodes
    end

    episodes << show.episodes_for_season(season)[0..episode - 1]
    episodes.flatten
  end

  def progress
    return 0 if season.zero? && episode.zero?

    total_episodes = show.seasons.reject(&:zero?).map do |season_number|
      show.episodes_for_season(season_number)
    end

    total_episode_count = total_episodes.flatten.size
    watched_episode_count = watched_episodes.size

    100 * watched_episode_count / total_episode_count.to_f
  end

  def <=>(other)
    show.name <=> other.show.name
  end

  class << self
    def for(user:, and_show:)
      where(user_id: user, show_id: and_show).first
    end

    def with_id(usershow_id)
      where(id: usershow_id).first
    end
  end
end
