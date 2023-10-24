require 'date'

class Item
  attr_accessor :genre, :author, :label, :source, :publish_date
  attr_reader :id, :archived

  def initialize(genre, author, label, source, publish_date, archived = false)
    @genre = genre
    @author = author
    @label = label
    @source = source
    @publish_date = publish_date
    @archived = archived
    @id = Random.rand(1..1000)
  end

  def can_be_archived?
    publish_date = Date.parse(@publish_date)
    (Date.today.year - publish_date.year) > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  private

  def id
    @id
  end

  def archived
    @archived
  end
end

