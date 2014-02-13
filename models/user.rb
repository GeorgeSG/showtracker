class User < Sequel::Model
  many_to_many :episodes
end
