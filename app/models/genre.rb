# Genres Model
class Genre < Sequel::Model
  many_to_many :shows, join_table: :shows_genres

  class << self
    def with_id(genre_id)
      where(id: genre_id).first
    end
  end
end
