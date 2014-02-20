require_relative '../spec_helper'

describe Usershow do
  before :each do
    @show = build(:show).save
    @user = build(:user).save
    @usershow = build(:usershow, show: @show, user: @user).save
  end

  it 'has a valid factory' do
    build(:usershow).should be_valid
  end

  context 'Season' do
    it 'can increment' do
      usershow = build(:usershow, show: @show, user: @user, season: 1)
      usershow.increment_season
      usershow.season.should == 2
      usershow.episode.should == 0
    end

    it 'can decrement' do
      usershow = build(:usershow, show: @show, user: @user, season: 1)
      usershow.decrement_season
      usershow.season.should == 0
      usershow.episode.should == 0
    end

    it 'does not decrement below zero' do
      usershow = build(:usershow, show: @show, user: @user, season: 0, episode: 2)
      usershow.decrement_season
      usershow.season.should == 0
      usershow.episode.should == 2
    end
  end

  context 'Episode' do
    it 'can increment' do
      usershow = build(:usershow, show: @show, user: @user, season: 1, episode: 2)
      usershow.increment_episode
      usershow.season.should == 1
      usershow.episode.should == 3
    end

    it 'can decrement episode' do
      usershow = build(:usershow, show: @show, user: @user, season: 1, episode: 2)
      usershow.decrement_episode
      usershow.season.should == 1
      usershow.episode.should == 1
    end

    it 'does not decrement below zero' do
      usershow = build(:usershow, show: @show, user: @user, season: 1, episode: 0)
      usershow.decrement_episode
      usershow.season.should == 1
      usershow.episode.should == 0
    end
  end

  context 'Progress' do
    it 'can return watched episodes' do
      show = build(:show).save
      user = build(:user).save
      usershow = build(:usershow, show: show, user: user, season: 3, episode: 2).save
      episode_one = build(:episode, season_number: 1, episode_number: 1).save
      episode_two = build(:episode, season_number: 2, episode_number: 3).save
      episode_three = build(:episode, season_number: 3, episode_number: 2).save
      episode_four = build(:episode, season_number: 3, episode_number: 1).save
      episode_five = build(:episode, season_number: 3, episode_number: 4).save
      episode_six = build(:episode, season_number: 4, episode_number: 4).save

      show.add_episode episode_one
      show.add_episode episode_two
      show.add_episode episode_three
      show.add_episode episode_four
      show.add_episode episode_five
      show.add_episode episode_six
      show.save

      usershow.refresh
      usershow.watched_episodes.should =~ [episode_one,
                                           episode_two,
                                           episode_three,
                                           episode_four]

      episode_one.destroy
      episode_two.destroy
      episode_three.destroy
      episode_four.destroy
      episode_five.destroy
      episode_six.destroy

      usershow.refresh
      usershow.watched_episodes.should be_empty

      show.destroy
      user.destroy
    end

    it 'can return progress'
  end

  context 'Queries' do
    it 'retrieves show' do
      @usershow.show.should == @show
    end

    it 'retrieves user' do
      @usershow.user.should == @user
    end
  end

  after :each do
    @usershow.destroy
    @show.destroy
    @user.destroy
  end
end
