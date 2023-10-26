require 'json'
require_relative '../modules/book_label_storage'
require_relative '../classes/book'
require_relative '../classes/label'

class JsonStorageTest
  include JsonStorage
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
  end
end

describe JsonStorage do
  let(:json_storage) { JsonStorageTest.new }
  let(:book_data) do
    [
      {
        'id' => 1,
        'title' => 'Book 1',
        'publish_date' => '2022-01-01',
        'publisher' => 'Publisher 1',
        'cover_state' => 'good',
        'archived' => false
      }
    ]
  end
  let(:label_data) { [{ 'id' => 1, 'title' => 'Label 1', 'color' => 'blue', 'items' => [{ 'id' => 1 }] }] }

  describe '#save_to_json' do
    it 'saves books and labels to JSON files' do
      book = Book.new(1, '2022-01-01', 'Publisher 1', 'good')
      json_storage.books = [book]
      label = Label.new(1, 'Label 1', 'blue')
      label.add_item(book)
      json_storage.labels = [label]

      json_storage.save_to_json

      books_json = File.read('./json/books.json')
      labels_json = File.read('./json/labels.json')

      expect(books_json).to eq(JSON.generate(json_storage.books.map(&:to_h)))
      expect(labels_json).to eq(JSON.generate(json_storage.labels.map(&:to_h)))
    end
  end

  describe '#load_from_json' do
    it 'loads books and labels from JSON files' do
      File.write('./json/books.json', JSON.generate(book_data))
      File.write('./json/labels.json', JSON.generate(label_data))

      json_storage.load_from_json

      expect(json_storage.books.length).to eq(1)
      expect(json_storage.labels.length).to eq(1)
    end

    it 'does not raise an error when JSON files do not exist' do
      expect { json_storage.load_from_json }.not_to raise_error
    end
  end
end
