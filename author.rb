class Author
  attr_reader :id, :first_name, :last_name
  attr_accessor :authors

  def initialize(first_name, last_name)
    @id = Random.rand(1..1000)
    @first_name = first_name
    @last_name = last_name
    @authors = []
  end

  def add_item(item)
    item.author = self
    @authors << item
  end
end
