class Genre < Sequel::Model
  many_to_many :shows, join_table: :shows_genres
end
