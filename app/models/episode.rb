class Episode < ActiveRecord::Base
  belongs_to :show

  validates_presence_of :show

  def upcoming?
    return nil if first_aired.empty?
    Time.parse(first_aired) > Time.now
  end
end
