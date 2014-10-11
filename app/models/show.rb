class Show < ActiveRecord::Base
  belongs_to :network

  has_many :episodes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions


  has_and_belongs_to_many :actors
  has_and_belongs_to_many :genres


  validates_presence_of :name
  validates_presence_of :network

  scope :top_rated, -> { order('rating_count DESC').limit(10) }

  scope :continuing, -> { where(status: 'continuing') }
  scope :ended,      -> { where(status: 'ended') }

  scope :with_name_like, -> (name) { where('LOWER(name) LIKE ?', "%#{name.downcase}%") }


  paginates_per 5

  def seasons
    episodes.group_by(&:season_number).keys
  end

  def seasons_count
    seasons.reject(&:zero?).count
  end

  def upcoming_episodes
    episodes.select(&:upcoming?)
  end
end
