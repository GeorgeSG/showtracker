class Show < Sequel::Model
  one_to_many :episodes
  one_to_many :usershows
  many_to_many :genres, join_table: :shows_genres
  many_to_many :actors

  alias :rating_api :rating

  def rating
    rating_api || 0
  end

  def seasons
    episodes.group_by(&:season_number).keys
  end

  def seasons_count
    seasons.count
  end

  def episodes_for_season(number)
    episodes.group_by(&:season_number)[number]
  end
end
