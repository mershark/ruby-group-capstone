require_relative '../classes/label'

describe Label do
  let(:label) { Label.new(1, 'Test Label', 'Red') }

  it 'has a title' do
    expect(label.title).to eq('Test Label')
  end

  it 'has a color' do
    expect(label.color).to eq('Red')
  end

  it 'can add items' do
    item = double('Item')
    allow(item).to receive(:label=).with(label)
    allow(item).to receive(:label).and_return(label)
    label.add_item(item)
    expect(label.items).to include(item)
    expect(item.label).to eq(label)
  end

  it 'can be converted to a hash' do
    label_hash = label.to_h
    expect(label_hash).to be_a(Hash)
    expect(label_hash).to have_key('id')
    expect(label_hash).to have_key('title')
    expect(label_hash).to have_key('color')
    expect(label_hash).to have_key('items')
  end

  it 'provides other data as a hash' do
    other_data = label.other_data
    expect(other_data).to be_a(Hash)
    expect(other_data).to have_key(:title)
    expect(other_data).to have_key(:color)
  end
end
