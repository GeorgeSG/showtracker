class Show < Sequel::Model
  one_to_many :episodes
  many_to_many :genres, join_table: :shows_genres
  many_to_many :actors
end
