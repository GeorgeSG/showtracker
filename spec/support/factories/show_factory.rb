FactoryGirl.define do
  factory :show do
    DAYS_OF_WEEK = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ].freeze

    name           { Faker::Commerce.product_name }
    api_id         { Faker::Number.number(20) }
    airs_day       { DAYS_OF_WEEK.sample }
    airs_time      { Faker::Time.forward(2, [:morning, :evening].sample) }
    content_rating { ['TV-Y', 'TV-G', 'TV-PG', 'TV-MA'].sample }
    first_aired    { Faker::Date.backward(365 * 10) }
    imdb_id        { Faker::Number.number(20) }
    language       { ['English', 'Bulgarian', 'Spanish', 'French'].sample }
    overview       { Faker::Lorem.paragraph }
    running_time   { [15, 20, 30, 40, 45, 60, 90].sample }
    status         { ['Running', 'Cancelled', 'Announced', 'Ended'].sample }

    added          { Faker::Date.backward(365) }
    added_by       { Faker::Name.name }

    last_updated   { Faker::Date.backward(14) }

    network
  end
end