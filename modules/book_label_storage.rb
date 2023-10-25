module JsonStorage
  def save_to_json
    save_books_to_json
    save_labels_to_json
  end

  def load_from_json
    load_books_from_json
    load_labels_from_json
  end

  private

  def save_books_to_json
    File.write('./json/books.json', JSON.generate(@books.map(&:to_h)))
  end

  def save_labels_to_json
    File.write('./json/labels.json', JSON.generate(@labels.map(&:to_h)))
  end

  def load_books_from_json
    return unless File.exist?('./json/books.json')

    file = File.read('./json/books.json')
    book_data = JSON.parse(file)
    @books = book_data.map { |data| create_book_from_data(data) }
  end

  def load_labels_from_json
    return unless File.exist?('./json/labels.json')

    file = File.read('./json/labels.json')
    label_data = JSON.parse(file)
    @labels = label_data.map { |data| create_label_from_data(data) }
  end

  def create_book_from_data(data)
    Book.new(
      data['id'],
      data['title'],
      data['author'],
      data['publish_date'],
      data['publisher'],
      data['cover_state'],
      archived: data['archived']
    )
  end

  def create_label_from_data(data)
    label = Label.new(data['id'], data['title'], data['color'])
    data['items'].each do |item_data|
      item = @books.find { |book| book.id == item_data['id'] }
      label.add_item(item) if item
    end
    label
  end
end
