class Show < ActiveRecord::Base
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :genres

  has_many :episodes, dependent: :destroy
  belongs_to :network

  validates_presence_of :name
end
