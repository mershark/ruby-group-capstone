require_relative '../classes/book'

describe Book do
  let(:book_id) { 1 }
  let(:title) { 'Sample Book' }
  let(:author) { 'John Doe' }
  let(:publish_date) { '2022-01-01' }
  let(:publisher) { 'Publisher X' }
  let(:cover_state) { 'good' }
  let(:archived) { false }

  describe 'initialization' do
    it 'creates a new Book instance' do
      book = Book.new(book_id, title, author, publish_date, publisher, cover_state, archived: archived)
      expect(book).to be_an_instance_of(Book)
    end

    it 'sets instance variables correctly' do
      book = Book.new(book_id, title, author, publish_date, publisher, cover_state, archived: archived)
      expect(book.id).to eq(book_id)
      expect(book.title).to eq(title)
      expect(book.author).to eq(author)
      expect(book.publish_date).to eq(publish_date)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
      expect(book.archived).to eq(archived)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the cover state is bad' do
      book = Book.new(book_id, title, author, publish_date, publisher, 'bad', archived: archived)
      expect(book.can_be_archived?).to be true
    end

    it 'returns false if the cover state is not bad' do
      book = Book.new(book_id, title, author, publish_date, publisher, 'good', archived: archived)
      expect(book.can_be_archived?).to be false
    end
  end

  describe '#to_h' do
    it 'returns a hash with book attributes' do
      book = Book.new(book_id, title, author, publish_date, publisher, cover_state, archived: archived)
      expected_hash = {
        'id' => book_id,
        'title' => title,
        'author' => author,
        'publish_date' => publish_date,
        'publisher' => publisher,
        'cover_state' => cover_state,
        'archived' => archived
      }
      expect(book.to_h).to eq(expected_hash)
    end
  end

  describe '#poor_cover_state' do
    it 'returns true if the cover state is bad' do
      book = Book.new(book_id, title, author, publish_date, publisher, 'bad', archived: archived)
      expect(book.poor_cover_state).to be true
    end

    it 'returns false if the cover state is not bad' do
      book = Book.new(book_id, title, author, publish_date, publisher, 'good', archived: archived)
      expect(book.poor_cover_state).to be false
    end
  end
end
