# Episodes Model
class Episode < Sequel::Model
  many_to_one :show

  def upcoming?
    return nil if first_aired.empty?
    Time.parse(first_aired) > Time.now
  end
end
