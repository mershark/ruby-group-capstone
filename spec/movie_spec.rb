require_relative '../classes/movie'

describe Movie do
  let(:genre) { 'Drama' }
  let(:author) { 'Alice Smith' }
  let(:label) { 'Movie Label' }
  let(:source) { 'Movie Source' }
  let(:publish_date) { '2015-05-20' }
  let(:silent) { true }

  subject(:movie) { Movie.new(publish_date, silent, genre, author, label, source) }

  describe '#initialize' do
    it 'sets the attributes correctly' do
      expect(movie.genre).to eq(nil)
      expect(movie.author).to eq(nil)
      expect(movie.label).to eq(nil)
      expect(movie.source).to eq(nil)
      expect(movie.publish_date).to eq(nil)
      expect(movie.silent).to eq(false)
      expect(movie.instance_variable_get(:@archived)).to be_falsey
      expect(movie.instance_variable_get(:@id)).to be_an(Integer)
    end
  end

  describe '#to_h' do
    let(:expected_hash) do
      {
        'genre' => nil,
        'author' => nil,
        'label' => nil,
        'source' => nil,
        'publish_date' => nil,
        'silent' => false
      }
    end

    it 'returns a hash with the movie details' do
      expect(movie.to_h).to eq(expected_hash)
    end
  end

  describe '#move_to_archive' do
    before { allow(movie).to receive(:can_be_archived?).and_return(true) }

    it 'archives the movie if it can be archived' do
      expect(movie.instance_variable_get(:@archived)).to be_falsey
      movie.move_to_archive
      expect(movie.instance_variable_get(:@archived)).to be_truthy
    end

    context 'when movie cannot be archived' do
      before { allow(movie).to receive(:can_be_archived?).and_return(false) }

      it 'does not archive the movie if it cannot be archived' do
        expect(movie.instance_variable_get(:@archived)).to be_falsey
        movie.move_to_archive
        expect(movie.instance_variable_get(:@archived)).to be_falsey
      end
    end
  end
end
