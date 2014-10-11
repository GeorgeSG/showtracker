FactoryGirl.define do
  factory :episode do
    api_id                  { Faker::Number.number(20) }
    combined_episode_number { rand 1..100 }
    combined_season         { rand 1..20 }
    director                { Faker::Name.name }
    name                    { Faker::Commerce.product_name }
    episode_number          { rand 1..25 }
    first_aired             { Faker::Date.backward(365 * 10) }
    imdb_id                 { Faker::Number.number(20) }
    language                { ['English', 'Bulgarian', 'Spanish', 'French'].sample }
    overview                { Faker::Lorem.paragraph }
    rating                  { rand 1.0..10.0 }
    rating_count            { Faker::Number.number(rand(1..5)) }
    season_number           { Faker::Number.digit }
    writer                  { Fakar::Name.name }
    airs_before_epsiode     { rand 1..100 }
    airs_before_season      { Faker::Number.digit }

    last_updated            { Faker::Date.backward(14) }
    season_api_id           { Faker::Number.number(20) }
    series_api_id           { Faker::Number.number(20) }

    show
  end
end