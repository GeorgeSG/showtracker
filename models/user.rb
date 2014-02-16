class User < Sequel::Model
  def shows
    episodes.map(&:season).map(&:show).uniq
  end

  many_to_many :episodes
end
