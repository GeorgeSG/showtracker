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

  def validate
    super
    errors.add(:username, 'can\'t be empty') if username.nil? || username.empty?
    errors.add(:password, 'can\'t be empty') if password.nil? || password.empty?
    errors.add(:salt, 'can\'t be empty') if salt.nil? || salt.empty?
  end
end
