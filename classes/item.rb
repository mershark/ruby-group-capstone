require 'date'

class Item
  attr_accessor :genre, :author, :label, :source, :publish_date

  def initialize(*args)
    @genre, @author, @label, @source, @publish_date, @silent = args
    @archived = false
    @id = Random.rand(1..1000)
  end

  def to_h
    {
      genre: @genre,
      author: @author,
      label: @label,
      source: @source.name,
      publish_date: @publish_date
    }
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  private

  def can_be_archived?
    publish_date = Date.parse(@publish_date)
    (Date.today.year - publish_date.year) >= 10
  end
end
