require_relative '../classes/item'
require_relative '../classes/source'

describe Source do
  let(:source) { Source.new('Sample Source') }

  describe '#initialize' do
    it 'initializes a source with the provided name' do
      expect(source.name).to eq('Sample Source')
    end

    it 'initializes a source with an ID between 1 and 1000' do
      expect(source.instance_variable_get(:@id)).to be_between(1, 1000)
    end

    it 'initializes a source with an empty list of items' do
      expect(source.instance_variable_get(:@items)).to eq([])
    end
  end

  describe '#add_item' do
    let(:item) { Item.new('Genre', '2020-01-01') }

    it 'adds an item to the source' do
      source.add_item(item)
      expect(source.instance_variable_get(:@items)).to eq([item])
    end

    it 'sets the source of the item to itself' do
      source.add_item(item)
      expect(item.source).to eq(source)
    end
  end

  describe '#to_h' do
    let(:expected) { { name: 'Sample Source', items: [] } }

    it 'returns a hash representation of the source' do
      expect(source.to_h).to eq(expected)
    end
  end

  describe '#to_s' do
    it 'returns the name of the source as a string' do
      expect(source.to_s).to eq('Sample Source')
    end
  end
end
