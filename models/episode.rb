class Episode < Sequel::Model
  many_to_one :season
  many_to_many :users
end
