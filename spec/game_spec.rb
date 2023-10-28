require_relative '../classes/genre'
require_relative '../classes/game'

describe Genre do
  describe 'when creating a new Genre' do
    it 'sets the name correctly' do
      name = 'Rock'
      genre = Genre.new(name) # Added .new here
      expect(genre.name).to eq(name)
    end

    it 'assigns a random id if not provided' do
      genre = Genre.new('Pop')
      expect(genre.id).to be_an(Integer)
    end

    it 'accepts a custom id if provided' do
      custom_id = 42
      genre = Genre.new('Jazz', id: custom_id)
      expect(genre.id).to eq(custom_id)
    end
  end

  describe 'when adding an item to the genre' do
    it 'updates the genre of the item' do
      genre = Genre.new('Country')
      item = double('Game', genre: nil) # Make sure 'item' is an instance of 'Game'
      allow(Date).to receive(:parse).and_return(Date.today - (2 * 365)) # Stub Date.parse with 2 years equivalent
      expect(item).to receive(:genre=).with(genre) # Set the expectation
      genre.add_item(item)
    end
  end
end
