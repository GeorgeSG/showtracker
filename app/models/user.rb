# Users Model
class User < Sequel::Model
  one_to_many :usershows

  def shows
    usershows.map(&:show)
  end

  def has_show?(show_id)
    shows.map(&:id).include? show_id
  end

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def watched?(season, episode)
    return nil if season.zero?

    usershow = usershows.select { |us| us.show_id == episode.show.id }.first
    return false if usershow.nil? || season > usershow.season
    return true  if season < usershow.season

    episode.episode_number <= usershow.episode
  end

  def validate
    super
    errors.add(:username, 'can\'t be empty') if username.nil? || username.empty?
    errors.add(:password, 'can\'t be empty') if password.nil? || password.empty?
    errors.add(:salt, 'can\'t be empty') if salt.nil? || salt.empty?
  end
end
