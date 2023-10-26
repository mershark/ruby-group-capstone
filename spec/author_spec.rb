require 'rspec'
require_relative '../classes/author'

describe Author do
  let(:author) { Author.new('John', 'Doe') }

  it 'has an ID within the range 1..1000' do
    expect(author.id).to be_between(1, 1000)
  end

  it 'has a first name' do
    expect(author.first_name).to eq('John')
  end

  it 'has a last name' do
    expect(author.last_name).to eq('Doe')
  end

  it 'initially has an empty list of items' do
    expect(author.items).to be_empty
  end

  it 'can add an item to its list of items' do
    item = double('item')
    expect(item).to receive(:author=).with(author)
    author.add_item(item)
    expect(author.items).to include(item)
  end
end
