module JsonStorage
  def save_album
    albums = @albums.map do |album|
      { id: album.instance_variable_get(:@id), publish_date: album.publish_date, on_spotify: album.on_spotify }
    end
    File.write('json/music.json', JSON.pretty_generate(albums))
  end

  def save_genre
    genres = @genres.map { |genre| { name: genre.name } }
    File.write('json/genre.json', JSON.pretty_generate(genres))
  end

  private

  def recover_genre
    return unless File.exist?('json/genre.json')

    genre_store = begin
      JSON.parse(File.read('json/genre.json'))
    rescue StandardError
      []
    end
    genre_load = genre_store.map { |genre| Genre.new(genre['name']) }
    @genres.concat(genre_load) unless genre_load.empty?
  end

  def recover_album
    return unless File.exist?('json/music.json')

    album_store = begin
      JSON.parse(File.read('json/music.json'))
    rescue StandardError
      []
    end
    album_load = album_store.map { |music| MusicAlbum.new(music['on_spotify'], music['publish_date']) }
    @albums.concat(album_load) unless album_load.empty?
  end
end
