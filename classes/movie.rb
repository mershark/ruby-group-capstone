require_relative 'item'

class Movie < Item
  attr_accessor :silent

  def initialize(*args)
    genre, author, label, source, publish_date, silent = args
    super(genre, author, label, source, publish_date)
    @silent = silent || false
  end

  def to_h
    {
      'genre' => genre,
      'author' => author,
      'label' => label,
      'source' => source,
      'publish_date' => publish_date,
      'silent' => silent
    }
  end

  private

  def can_be_archived?
    super || silent
  end
end
