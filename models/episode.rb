class Episode < Sequel::Model
  many_to_one :season
end
