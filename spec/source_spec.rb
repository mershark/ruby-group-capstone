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
      expect(source.instance_variable_get(:@items)).to be_empty
    end
  end

  describe '#add_item' do
    it 'adds an item to the source' do
      item = Item.new('Genre 1', 'Author 1', 'Label 1', source, '2020-01-01')
      source.add_item(item)
      expect(source.instance_variable_get(:@items)).to include(item)
    end

    it 'sets the source of the item to itself' do
      item = Item.new('Genre 2', 'Author 2', 'Label 2', source, '2021-02-02')
      source.add_item(item)
      expect(item.source).to eq(source)
    end
  end

  describe '#to_h' do
    it 'returns a hash representation of the source' do
      item1 = Item.new('Genre 3', 'Author 3', 'Label 3', source, '2019-03-03')
      item2 = Item.new('Genre 4', 'Author 4', 'Label 4', source, '2018-04-04')
      source.add_item(item1)
      source.add_item(item2)

      expected_hash = {
        name: 'Sample Source',
        items: [item1.to_h, item2.to_h]
      }

      expect(source.to_h).to eq(expected_hash)
    end
  end

  describe '#to_s' do
    it 'returns the name of the source as a string' do
      expect(source.to_s).to eq('Sample Source')
    end
  end
end
