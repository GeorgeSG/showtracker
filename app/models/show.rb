# Shows Model
class Show < Sequel::Model
  one_to_many :episodes
  one_to_many :usershows
  many_to_one :network
  many_to_many :genres, join_table: :shows_genres
  many_to_many :actors

  def seasons
    episodes.group_by(&:season_number).keys
  end

  def seasons_count
    seasons.reject(&:zero?).count
  end

  def episodes_for_season(number)
    episodes.group_by(&:season_number)[number].sort_by!(&:episode_number)
  end

  def upcoming
    episodes.select(&:upcoming?)
  end

  class << self
    def with_id(show_id)
      where(id: show_id).first
    end
  end
end
