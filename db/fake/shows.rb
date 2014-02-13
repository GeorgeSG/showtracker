require './fake_helpers'

shows = DB[:shows].delete
seasons = DB[:seasons].delete
episodes = DB[:episodes].delete

500.times do
  show = Show.create(
    name: Faker::Commerce.product_name
  )

  (1..6).each do |i|
    season = Season.new(number: i)
    season.show = show

    (1..15).each do |e|
      episode = Episode.new(name: "Episode #{e}")
      season.add_episode episode
      episode.save
    end

    season.save
  end
end

