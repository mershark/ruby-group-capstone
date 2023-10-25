require 'date'
require_relative '../classes/item'

describe Item do
  let(:genre) { 'Fiction' }
  let(:author) { 'John Doe' }
  let(:label) { 'Sample Label' }
  let(:source) { 'Sample Source' }
  let(:publish_date) { '2010-01-15' }
  subject(:item) { Item.new(genre, author, label, source, publish_date) }

  describe '#initialize' do
    it 'sets the attributes correctly' do
      expect(item.genre).to eq(genre)
      expect(item.author).to eq(author)
      expect(item.label).to eq(label)
      expect(item.source).to eq(source)
      expect(item.publish_date).to eq(publish_date)
      expect(item.instance_variable_get(:@archived)).to be_falsey
      expect(item.instance_variable_get(:@id)).to be_an(Integer)
    end
  end

  describe '#move_to_archive' do
    it 'archives the item if it can be archived' do
      expect(item.instance_variable_get(:@archived)).to be_falsey
      item.move_to_archive
      expect(item.instance_variable_get(:@archived)).to be_truthy
    end

    it 'does not archive the item if it cannot be archived' do
      future_date = (Date.today + 5).strftime('%Y-%m-%d')
      item = Item.new(genre, author, label, source, future_date)
      expect(item.instance_variable_get(:@archived)).to be_falsey
      item.move_to_archive
      expect(item.instance_variable_get(:@archived)).to be_falsey
    end
  end
end
