# Actors Model
class Actor < Sequel::Model
  many_to_many :shows

  def validate
    super
    errors.add(:name, 'can\'t be empty') if name.nil? || name.empty?
  end

  class << self
    def with_id(actor_id)
      where(id: actor_id).first
    end
  end
end
