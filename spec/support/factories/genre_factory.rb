FactoryGirl.define do
  factory :genre do
    GENRES = [
      'Action',
      'Adventure',
      'Comedy',
      'Crime',
      'Faction',
      'Fantasy',
      'Historical',
      'Horror',
      'Mystery',
      'Paranoid',
      'Philosophical',
      'Political',
      'Realistic',
      'Romance',
      'Saga',
      'Satire',
      'Science fiction',
      'Slice of Life',
      'Speculative',
      'Thriller',
      'Urban'
    ].freeze

    name { GENRES.sample }
  end
end