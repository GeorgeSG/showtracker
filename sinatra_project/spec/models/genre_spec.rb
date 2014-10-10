require_relative '../spec_helper'

describe Genre do
  it 'has a valid factory' do
    build(:genre).should be_valid
  end

  context 'Validations' do
    it 'is invalid without a name' do
      build(:genre, name: nil).should_not be_valid
    end
  end

  context 'Queries' do
    before :each do
      @genre = build(:genre).save
    end

    it 'retrieves all shows in the genre' do
      show_one = build(:show).save
      show_two = build(:show).save

      @genre.shows.push show_one
      @genre.shows.push show_two
      @genre.save

      @genre.shows.should =~ [show_one, show_two]

      show_one.destroy
      show_two.destroy

      @genre.refresh
      @genre.shows.should be_empty
    end

    it 'finds a genre by id' do
      Genre.with_id(@genre.id).should == @genre
    end

    after :each do
      @genre.destroy
    end
  end
end
