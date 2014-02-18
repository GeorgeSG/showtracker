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

  def <=>(other)
    show.name <=> other.show.name
  end

  class << self
    def for_user_and_show(user_id, show_id)
      where(user_id: user_id, show_id: show_id).first
    end

    def with_id(usershow_id)
      where(id: usershow_id).first
    end
  end
end
