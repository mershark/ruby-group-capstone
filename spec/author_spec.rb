require_relative '../author'

describe Author do
  let(:author) { Author.new('John', 'Doe') }
  let(:game) { Game.new('2012-01-01', false, true, '2014-01-01', author) }

  describe '#add_item' do
    context 'when the item is a game' do
      it 'sets the author of the game' do
        author.add_item(game)
        expect(game.author).to eq(author)
      end
    end
  end
end
