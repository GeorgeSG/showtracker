FactoryGirl.define do
  factory :episode do |f|
    f.api_id { Faker::Number.number(6).to_s }
    f.combined_episode_number { Faker::Number.digit }
    f.combined_season { Faker::Number.digit }
    f.director { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    f.name { Faker::Internet.user_name }
    f.episode_number { Faker::Number.digit }
    f.first_aired { Time.at(0.0 + rand * (Time.now.to_f - 0.0)).strftime('%Y-%m-%d') }
    f.imdb_id { Faker::Number.number(6).to_s }
    f.language { Faker::Config.locale }
    f.overview { Faker::Lorem.paragraph }
    f.rating { rand * (10 - 1) + 1 }
    f.rating_count { Faker::Number.number(3) }
    f.writer { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    f.airs_before_episode { Faker::Number.digit }
    f.airs_before_season { Faker::Number.digit }
    f.last_updated { Time.at(0.0 + rand * (Time.now.to_f - 0.0)).strftime('%Y-%m-%d') }
    f.season_api_id { Faker::Number.number(6).to_s }
    f.series_api_id { Faker::Number.number(6).to_s }
  end
end
