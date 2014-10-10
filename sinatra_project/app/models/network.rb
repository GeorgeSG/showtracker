# Networks Model
class Network < Sequel::Model
  one_to_many :shows

  def validate
    super
    errors.add(:name, 'can\'t be empty') if name.nil? || name.empty?
  end

  class << self
    def with_id(network_id)
      where(id: network_id).first
    end
  end
end
