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
    it 'retrieves all shows in the genre'
    it 'finds a genre by id'
  end
end
