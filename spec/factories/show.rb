FactoryGirl.define do
  factory :show do |f|
    air_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Weekend']
    runtimes = [30, 45, 60, 90]
    statuses = ['Continuing', 'Ended']

    f.name { Faker::Internet.user_name }
    f.api_id { Faker::Number.number(6).to_s }
    f.airs_day { air_days.sample }
    f.airs_time { Time.at(0.0 + rand * (Time.now.to_f - 0.0)).strftime('%Y-%m-%d') }
    f.language { Faker::Config.locale }
    f.overview { Faker::Lorem.paragraph }
    f.rating   { rand * (10 - 1) + 1 }
    f.rating_count { Faker::Number.number(3) }
    f.running_time { runtimes.sample }
    f.status { statuses.sample }
  end
end
