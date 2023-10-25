require_relative '../game'
describe Game do
  let(:game) { Game.new(publish_date, archived, multiplayer, last_played_at, author) }
  let(:publish_date) { '2012-01-01' }
  let(:archived) { false }
  let(:multiplayer) { true }
  let(:last_played_at) { '2014-01-01' }
  let(:author) { Author.new('John', 'Doe') }
  describe '#can_be_archived?' do
    context 'when the game is archived and last played over two years ago' do
      let(:archived) { true }
      let(:last_played_at) { '2014-01-01' }
      it 'returns true' do
        expect(game.can_be_archived?).to eq(true)
      end
    end
    context 'when the game is not archived' do
      let(:archived) { false }
      context 'and the game was last played over two years ago' do
        let(:last_played_at) { '2014-01-01' }
        it 'returns false' do
          expect(game.can_be_archived?).to eq(true)
        end
      end
      context 'and the game was last played less than two years ago' do
        let(:last_played_at) { '2015-01-01' }
        it 'returns false' do
          expect(game.can_be_archived?).to eq(true)
        end
      end
    end
    context 'when the game is archived' do
      let(:archived) { true }
      context 'and the game was last played over two years ago' do
        let(:last_played_at) { '2014-01-01' }
        it 'returns true' do
          expect(game.can_be_archived?).to eq(true)
        end
      end
    end
  end
end