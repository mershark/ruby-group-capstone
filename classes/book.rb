require_relative 'item'

class Book < Item
  attr_accessor :id, :title, :publish_date, :publisher, :cover_state, :archived

  def initialize(id, publish_date, publisher, cover_state, options = {})
    super(publish_date, archived)
    @id = id
    @publisher = publisher
    @cover_state = cover_state
    @publish_date = publish_date
    @archived = options[:archived] || false
  end

  def can_be_archived?
    super || poor_cover_state
  end

  def to_h
    {
      'id' => @id,
      'title' => @title,
      'author' => @author,
      'publish_date' => @publish_date,
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'archived' => @archived
    }
  end

  def poor_cover_state
    @cover_state == 'bad'
  end
end
