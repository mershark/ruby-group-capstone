require_relative 'item'

class MusicAlbum < Item
  attr_reader :on_spotify

  def initialize(on_spotify, publish_date = '', genre = '', author = '', label = '', source = '')
    super(genre, author, label, source, publish_date)
    @on_spotify = on_spotify
    @id = Random.rand(1..1000)
  end

  def can_be_archived?
    super && on_spotify == true && album_age >= 10
  end
  
  private
  
  def album_age
    publish_date = Date.parse(@publish_date)
    current_year = Date.today.year
    current_year - publish_date.year
  end
end
