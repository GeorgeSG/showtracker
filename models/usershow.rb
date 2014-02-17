class Usershow < Sequel::Model
  many_to_one :show
  many_to_one :user

  def increment_season
    self.episode = 0
    self.season = (season.nil? ? 1 : season + 1)
  end

  def decrement_season
    unless season.nil? || season.zero?
      self.episode = 0
      self.season -= 1
    end
  end

  def increment_episode
    self.season = 1 if season.nil? || season.zero?
    self.episode = (episode.nil? ? 1 : episode + 1)
  end

  def decrement_episode
      unless episode.nil? || episode.zero?
        self.episode -= 1
      end
  end

  def <=>(other)
    show.name <=> other.show.name
  end

  class << self
    def for_user_and_show(user_id, show_id)
      Usershow.where(user_id: user_id, show_id: show_id).first
    end

    def with_id(usershow_id)
      Usershow.where(id: usershow_id).first
    end
  end
end
