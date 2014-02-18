# Users Model
class User < Sequel::Model
  one_to_many :usershows

  def shows
    usershows.map(&:show)
  end

  def has_show?(show_id)
    shows.map(&:id).include? show_id
  end
end
