require_relative '../author'
require_relative '../book'

describe Author do
  let(:author) { Author.new('John', 'Doe') }
  let(:game) { Game.new('2012-01-01', false, true, '2014-01-01', author) }
  let(:book) { Book.new('2012-01-01', false, 'The Great Gatsby', 'F. Scott Fitzgerald', author) }
  let(:movie) { Movie.new('2012-01-01', false, 'The Godfather', 'Francis Ford Coppola', author) }
  describe '#add_item' do
    context 'when the item is a game' do
      it 'adds the item to the author' do
        author.add_item(game)
        expect(author.items).to include(game)
      end
      it 'sets the author of the game' do
        author.add_item(game)
        expect(game.author).to eq(author)
      end
    end
  end
end