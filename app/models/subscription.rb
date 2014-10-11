class Subscription < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
end
