class Genre
  attr_reader :id
  attr_accessor :name, :items

  def initialize(name, id: Random.rand(1..1000))
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self # Ensure you set the genre of the item
  end
end
