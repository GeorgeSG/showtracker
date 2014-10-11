class Episode < ActiveRecord::Base
  belongs_to :show

  validates_presence_of :name
  validates_presence_of :show
end
