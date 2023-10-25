require 'json'
require_relative 'classes/music_album'
require_relative 'classes/genre'

class App
  attr_accessor :albums, :genres
  def initialize
    # Initialize collections for various item types
    @books = []
    @albums =  []
    @genres =  [] 
    @movies = [] 
    @games = []
    recover_genre
    recover_album
  end

  def list_books
    puts 'Listing all books:'
    # Implement code to list books here
  end

  def add_book
    puts 'Adding a book:'
    # Implement code to add a book here
  end

  def list_all_music_albums
    puts 'No music added' if @albums.empty?
    @albums.each do |album|
      puts "Publish date: #{album.publish_date}, On spotify: #{album.on_spotify}"
    end
    puts ''
  end

  def add_music_album
    print 'Publish date (Year-MM-DD): '
    publish_date = gets.chomp
    print 'On spotify (true,false): '
    on_spotify = gets.chomp

    music_album = MusicAlbum.new(on_spotify, publish_date)
    @albums << music_album
    puts 'Album created successfully'
    puts ''

    print 'Add genre (Comedy, Horror): '
    name = gets.chomp
    @genres << Genre.new(name)
    puts "#{name} genre created successfully"
    puts ''
    save_album
    save_genre
  end


  def list_genres
    puts 'No genre added' if @genres.empty?
    @genres.each { |genre| puts "Genre:  #{genre.name}" }
    puts ''
  end

  def save_album
    albums = @albums.map do |album|
      { id: album.instance_variable_get(:@id), publish_date: album.publish_date, on_spotify: album.on_spotify }
    end
    File.write('json/music.json', JSON.pretty_generate(albums))
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


  def save_genre
    genres = @genres.map { |genre| { name: genre.name } }
    File.write('json/genre.json', JSON.pretty_generate(genres))
  end

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














  def list_movies
    puts 'Listing all movies:'
    # Implement code to list movies here
  end

  def add_movie
    puts 'Adding a movie:'
    # Implement code to add a movie here
  end

  def list_games
    puts 'Listing all games:'
    # Implement code to list games here
  end

  def add_game
    puts 'Adding a game:'
    # Implement code to add a game here
  end

  def exit_app
    puts 'Exiting the Catalog App. Goodbye!'
    exit
  end
end
