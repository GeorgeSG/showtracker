require_relative '../spec_helper'

describe Episode do
  it 'has a valid factory' do
    build(:episode).should be_valid
  end

  context 'Queries' do
    it 'retrieves show' do
      episode = build(:episode).save
      show = build(:show).save

      show.add_episode episode
      show.save

      episode.refresh
      episode.show.should == show

      episode.destroy
      show.refresh

      show.episodes.should_not include(episode)
      show.destroy
    end

    it 'is upcoming if first_aired is in future' do
      episode = build(:episode, first_aired: Time.now + 1000)
      episode.upcoming?.should be_true
    end

    it 'is not upcoming if first_aired is in past' do
      episode = build(:episode, first_aired: Time.now - 1000)
      episode.upcoming?.should be_false
    end
  end
end
