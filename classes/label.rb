class Label
  attr_reader :id, :title, :color
  attr_accessor :items

  def initialize(_id, title, color)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
  end

  def to_h
    {
      'id' => @id,
      'title' => @title,
      'color' => @color,
      'items' => @items.map(&:to_h)
    }
  end

  def other_data
    {
      title: @title,
      color: @color
    }
  end
end
