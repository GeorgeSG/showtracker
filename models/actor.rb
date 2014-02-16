class Actor < Sequel::Model
  many_to_many :shows
end
