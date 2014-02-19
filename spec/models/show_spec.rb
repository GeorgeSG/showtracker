require_relative '../spec_helper'

describe Show do
  it 'has a valid factory' do
    build(:show).should be_valid
  end

  context 'Queries' do
    before :each do
      @show = build(:show).save
    end

    it 'retrieves all genres' do
      genre_one = build(:genre).save
      genre_two = build(:genre).save

      @show.add_genre genre_one
      @show.add_genre genre_two
      @show.save

      @show.genres.should =~ [genre_one, genre_two]

      genre_one.destroy
      genre_two.destroy

      @show.refresh
      @show.genres.should be_empty
    end

    it 'retrieves all usershows' do
      user_one = build(:user).save
      user_two = build(:user).save
      usershow_one = build(:usershow, show: @show, user: user_one).save
      usershow_two = build(:usershow, show: @show, user: user_two).save

      @show.usershows.should =~ [usershow_one, usershow_two]

      usershow_one.destroy
      usershow_two.destroy
      user_one.destroy
      user_two.destroy

      @show.refresh
      @show.usershows.should be_empty
    end

    it 'retrieves all episodes' do
      episode_one = build(:episode).save
      episode_two = build(:episode).save

      @show.add_episode episode_one
      @show.add_episode episode_two
      @show.save

      @show.episodes.should =~ [episode_one, episode_two]

      episode_one.destroy
      episode_two.destroy
      @show.refresh

      @show.episodes.should be_empty
    end

    it 'retrieves all actors' do
      actor_one = build(:actor).save
      actor_two = build(:actor).save

      @show.add_actor actor_one
      @show.add_actor actor_two
      @show.save

      @show.actors.should =~ [actor_one, actor_two]

      actor_one.destroy
      actor_two.destroy

      @show.refresh
      @show.actors.should be_empty
    end

    it 'retrieves the show\'s network' do
      network = build(:network).save
      @show.network = network
      @show.save
      @show.refresh

      @show.network.should == network

      network.destroy

      @show.refresh
      @show.network.should be_nil
    end

    it 'retrieves all seasons' do
      episode_one    = build(:episode, season_number: 1).save
      episode_two    = build(:episode, season_number: 2).save
      episode_three  = build(:episode, season_number: 2).save
      episode_four   = build(:episode, season_number: 3).save

      @show.add_episode episode_one
      @show.add_episode episode_two
      @show.add_episode episode_three
      @show.add_episode episode_four
      @show.save
      @show.refresh

      @show.episodes.should =~ [episode_one,
                                episode_two,
                                episode_three,
                                episode_four]

      @show.seasons.should =~ [1, 2, 3]

      episode_one.destroy
      episode_two.destroy
      episode_three.destroy
      episode_four.destroy
      @show.refresh

      @show.seasons.should be_empty
    end

    it 'retrieves seasons count' do
      episode_one    = build(:episode, season_number: 1).save
      episode_two    = build(:episode, season_number: 2).save
      episode_three  = build(:episode, season_number: 2).save
      episode_four   = build(:episode, season_number: 3).save

      @show.add_episode episode_one
      @show.add_episode episode_two
      @show.add_episode episode_three
      @show.add_episode episode_four
      @show.save
      @show.refresh

      @show.seasons_count.should == 3

      episode_one.destroy
      episode_two.destroy
      episode_three.destroy
      episode_four.destroy
      @show.refresh
      @show.seasons_count.should == 0
    end

    it 'retrieves all episode for a given season' do
      episode_one    = build(:episode, season_number: 1).save
      episode_two    = build(:episode, season_number: 2).save
      episode_three  = build(:episode, season_number: 2).save

      @show.add_episode episode_one
      @show.add_episode episode_two
      @show.add_episode episode_three
      @show.save
      @show.refresh

      @show.episodes_for_season(2).should =~ [episode_two, episode_three]

      episode_one.destroy
      episode_two.destroy
      episode_three.destroy
      @show.refresh

      @show.episodes_for_season(1).should be_empty
    end

    it 'retrieves all upcoming episodes' do
      episode_one    = build(:episode, first_aired: Time.now + 500).save
      episode_two    = build(:episode, first_aired: Time.now + 1000).save
      episode_three  = build(:episode, first_aired: Time.now - 1000).save

      @show.add_episode episode_one
      @show.add_episode episode_two
      @show.add_episode episode_three
      @show.save
      @show.refresh

      @show.upcoming.should =~ [episode_one, episode_two]

      episode_one.destroy
      episode_two.destroy
      episode_three.destroy
      @show.refresh

      @show.upcoming.should be_empty
    end

    it 'retrieves the next upcoming episode' do
      episode_one    = build(:episode, first_aired: Time.now + 500).save
      episode_two    = build(:episode, first_aired: Time.now + 1000).save
      episode_three  = build(:episode, first_aired: Time.now - 1000).save

      @show.add_episode episode_one
      @show.add_episode episode_two
      @show.add_episode episode_three
      @show.save
      @show.refresh

      @show.next_episode.should == episode_one

      episode_one.destroy
      episode_two.destroy
      episode_three.destroy
      @show.refresh

      @show.next_episode.should be_nil
    end

    it 'finds a show by id' do
      Show.with_id(@show.id).should == @show
    end

    after :each do
      @show.destroy
    end
  end
end
