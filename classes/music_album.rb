require_relative 'item'

class MusicAlbum < Item
  attr_reader :on_spotify, :publish_date

  def initialize(on_spotify, publish_date)
    super(nil, nil, nil, nil, publish_date)
    @on_spotify = on_spotify
    @id = Random.rand(1..1000)
  end
  

  def can_be_archived?
    super && on_spotify == true
  end
end
