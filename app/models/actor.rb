# Actors Model
class Actor < Sequel::Model
  many_to_many :shows

  class << self
    def with_id(actor_id)
      where(id: actor_id).first
    end
  end
end
