require_relative '../classes/item'
require_relative '../classes/movie'

describe Movie do
  let(:genre) { 'Drama' }
  let(:author) { 'Alice Smith' }
  let(:label) { 'Movie Label' }
  let(:source) { 'Movie Source' }
  let(:publish_date) { '2015-05-20' }
  let(:silent) { true }

  subject(:movie) { Movie.new(genre, author, label, source, publish_date, silent) }

  describe '#initialize' do
    it 'sets the attributes correctly' do
      expect(movie.genre).to eq(genre)
      expect(movie.author).to eq(author)
      expect(movie.label).to eq(label)
      expect(movie.source).to eq(source)
      expect(movie.publish_date).to eq(publish_date)
      expect(movie.silent).to eq(silent)
      expect(movie.instance_variable_get(:@archived)).to be_falsey
      expect(movie.instance_variable_get(:@id)).to be_an(Integer)
    end
  end

  describe '#to_h' do
    it 'returns a hash with the movie details' do
      expected_hash = {
        'genre' => genre,
        'author' => author,
        'label' => label,
        'source' => source,
        'publish_date' => publish_date,
        'silent' => silent
      }
      expect(movie.to_h).to eq(expected_hash)
    end
  end

  describe '#move_to_archive' do
    it 'archives the movie if it can be archived' do
      expect(movie.instance_variable_get(:@archived)).to be_falsey
      movie.move_to_archive
      expect(movie.instance_variable_get(:@archived)).to be_truthy
    end

    it 'does not archive the movie if it cannot be archived' do
      future_date = (Date.today + 5).strftime('%Y-%m-%d')
      movie = Movie.new(genre, author, label, source, future_date, false)
      expect(movie.instance_variable_get(:@archived)).to be_falsey
      movie.move_to_archive
      expect(movie.instance_variable_get(:@archived)).to be_falsey
    end

    it 'archives the movie if it is silent, regardless of the publish date' do
      future_date = (Date.today + 5).strftime('%Y-%m-%d')
      movie = Movie.new(genre, author, label, source, future_date, true)
      expect(movie.instance_variable_get(:@archived)).to be_falsey
      movie.move_to_archive
      expect(movie.instance_variable_get(:@archived)).to be_truthy
    end
  end
end
