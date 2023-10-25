require_relative 'item'

class Source
  attr_accessor :name

  def initialize(name)
    @name = name
    @id = Random.rand(1..1000)
    @items = []
  end

  def add_item(item)
    @items << item
    item.source = self
  end

  def to_h
    {
      name: @name,
      items: @items.map(&:to_h)
    }
  end

  def to_s
    @name
  end
end
