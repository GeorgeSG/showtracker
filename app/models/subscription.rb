class Subscription < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates_presence_of :show
  validates_presence_of :user

  validates_uniqueness_of :show_id, scope: :user_id
end
