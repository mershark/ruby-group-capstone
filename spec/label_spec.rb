require_relative '../classes/label'
require_relative '../classes/book'

describe Label do
  let(:label_id) { 1 }
  let(:label_title) { 'Fiction' }
  let(:label_color) { 'blue' }

  # Stub the generate_id method to return a fixed value
  before do
    allow_any_instance_of(Label).to receive(:generate_id).and_return(label_id)
  end

  describe 'initialization' do
    it 'creates a new Label instance' do
      label = Label.new(label_id, label_title, label_color)
      expect(label).to be_an_instance_of(Label)
    end

    it 'sets instance variables correctly' do
      label = Label.new(label_id, label_title, label_color)
      expect(label.id).to eq(label_id)
      expect(label.title).to eq(label_title)
      expect(label.color).to eq(label_color)
    end
  end

  describe '#add_item' do
    it 'adds an item to the label' do
      book = Book.new(1, 'Sample Book', 'John Doe', '2022-01-01', 'Publisher X', 'good', archived: false)
      label = Label.new(label_id, label_title, label_color)

      label.add_item(book)

      expect(label.items).to include(book)
      expect(book.label).to eq(label)
    end
  end

  describe '#to_h' do
    it 'returns a hash with label attributes' do
      label = Label.new(label_id, label_title, label_color)
      book = Book.new(1, 'Sample Book', 'John Doe', '2022-01-01', 'Publisher X', 'good', archived: false)
      label.add_item(book)

      expected_hash = {
        'id' => label_id,
        'title' => label_title,
        'color' => label_color,
        'items' => [book.to_h]
      }
      expect(label.to_h).to eq(expected_hash)
    end
  end

  describe '#other_data' do
    it 'returns a hash with title and color' do
      label = Label.new(label_id, label_title, label_color)
      expected_hash = {
        title: label_title,
        color: label_color
      }
      expect(label.other_data).to eq(expected_hash)
    end
  end
end
