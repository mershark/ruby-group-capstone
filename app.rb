require 'json'
require './classes/game'
require './classes/item'
require './classes/author'
require './classes/movie'
require './classes/source'
require './classes/book'
require './classes/label'
require './modules/book_label_storage'
require_relative 'classes/music_album'
require_relative 'classes/genre'
require_relative 'classes/movie'
require_relative 'classes/source'
require_relative 'modules/music_genre_storage'

class App
  include JsonStorage
  attr_accessor :albums, :genres
  def initialize
    @books = []
    @albums = []
    @genres = []
    @movies = load_movies || []
    @games = []
    @labels = []
    @authors = []
    @sources = load_sources || []
    load_data
    load_from_json
    recover_genre
    recover_album
  end
  
  # added from here....MERSHARK...........MERSHARK...........
  def list_books
    puts 'Listing all books:'
    @books.each do |book|
      puts "Title: #{book.title}"
      puts "Publisher: #{book.publisher}"
      puts "Cover State: #{book.cover_state}"
      puts "Published Date: #{book.publish_date}"
      puts "Archived: #{book.archived}"
      puts "ID: #{book.id}"
      puts '--------'
    end
  end

  def list_labels
    puts 'Listing all labels:'
    @labels.each do |label|
      puts "Title: #{label.title}"
      puts "Color: #{label.color}"
      puts 'Items: '
      label.items.each do |item|
        puts "  Publisher: #{item.publisher}"
        puts "  ID: #{item.id}"
      end
      puts '--------'
    end
  end

  def add_book
    puts 'Adding a book:'
    puts 'Enter the publisher: '
    publisher = gets.chomp
    puts 'Enter the cover state (e.g., good, bad): '
    cover_state = gets.chomp
    puts 'Enter the published date (yyyy-mm-dd): '
    publish_date = gets.chomp
    puts 'Enter label title (e.g. gift, new): '
    label_title = gets.chomp
    puts 'Enter label color (e.g. blue, red): '
    label_color = gets.chomp

    book_id = rand(1000)

    # Create a new book instance
    new_book = Book.new(book_id, publish_date, publisher, cover_state, archived: false)

    label = Label.new(rand(1000), label_title, label_color)
    label.add_item(new_book)

    # Add the new book to the collection
    @books << new_book
    @labels << label

    save_to_json
    puts 'Book added!'
  end
  # to here...........MERSHARK................................

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

  # added from here.............EVANS...........
  def list_movies
    puts 'Listing all movies:'
    @movies.each_with_index do |movie, index|
      puts "#{index + 1}. Genre #{movie.genre}, Author: #{movie.author}, Release Date: #{movie.publish_date}, "
    end
    puts ''
  end

  def add_movie
    puts 'Adding a movie:'
    genre = prompt_user_input('Genre')
    author = prompt_user_input('Author')
    label = prompt_user_input('Label')
    source_name = prompt_user_input('Source')
    release_date = prompt_user_input('Release Date (YYYY-MM-DD)')
    silent = prompt_user_input('Is it silent (true/false)?').downcase == 'true'

    source = find_or_create_source(source_name)
    movie = Movie.new(genre, author, label, source, release_date, silent)
    source.add_item(movie)
    @movies << movie

    save_movies
    save_sources
    puts 'Movie added successfully!'
  end

  def prompt_user_input(prompt)
    print "#{prompt}: "
    gets.chomp
  end

  def find_or_create_source(name)
    source = @sources.find { |s| s.name == name }
    if source.nil?
      source = Source.new(name)
      @sources << source
    end
    source
  end

  def list_sources
    puts 'Listing all sources:'
    @sources.each_with_index do |source, index|
      puts "#{index + 1}. Name: #{source.name}"
    end
    puts ''
  end

  def add_source
    puts 'Adding a source:'
    print 'Name: '
    name = gets.chomp

    source = Source.new(name)
    @sources << source

    save_sources
    puts 'Source added successfully!'
  end
  # to here..........EVANS...........

  # added from here............Fatuma..........
  def add_game
    puts 'Enter the publish date of the game (e.g., yyyy-mm-dd):'
    publish_date = gets.chomp

    puts 'Is the game archived? (true/false):'
    archived = gets.chomp.downcase == 'true'

    puts 'Is the game multiplayer? (true/false):'
    multiplayer = gets.chomp.downcase == 'true'

    puts 'Enter the last played at date of the game (e.g., yyyy-mm-dd):'
    last_played_at = gets.chomp

    puts 'Enter the author name (e.g., John Doe):'
    author_name = gets.chomp
    first_name, last_name = author_name.split
    author = Author.new(first_name, last_name) # Create a new Author object

    game = Game.new(publish_date, archived, multiplayer, last_played_at, author)
    @games << game
    @authors << author # Add the new author to the authors array
    save_games
    save_authors
    puts 'Game added successfully!'
  end

  def list_games
    puts 'Listing games...'
    @games.each do |game|
      puts "Publish Date: #{game.publish_date}"
      puts "Archived: #{game.archived}"
      puts "Multiplayer: #{game.multiplayer}"
      puts "Last Played At: #{game.last_played_at}"
      puts
    end
  end

  def list_authors
    puts 'Listing authors...'
    @authors.each do |author|
      puts "ID: #{author.id}, Name: #{author.first_name} #{author.last_name}"
    end
  end

  # # Preserve data
  def get_data(file_name)
    if File.exist?("json/#{file_name}.json")
      File.read("json/#{file_name}.json")
    else
      empty_json = [].to_json
      File.write("json/#{file_name}.json", empty_json)
      empty_json
    end
  end

  # # load data
  def load_data
    games = JSON.parse(get_data('games'))
    authors = JSON.parse(get_data('authors'))

    games.each do |game|
      @games << Game.new(game['publish_date'], game['archived'], game['multiplayer'], game['last_played_at'],
                         game['author'])
    end

    authors.each do |author|
      @authors << Author.new(author['id'], author['name'])
    end
  end

  # save games to database
  def save_games
    update_games = []
    @games.each do |game|
      update_games << { 'publish_date' => game.publish_date, 'archived' => game.archived,
                        'multiplayer' => game.multiplayer, 'last_played_at' => game.last_played_at }
    end

    File.write('json/games.json', JSON.generate(update_games))
  end

  # save authors to the database
  def save_authors
    authors_data = @authors.map do |author|
      { 'id' => author.id, 'first_name' => author.first_name, 'last_name' => author.last_name }
    end

    File.write('json/authors.json', JSON.generate(authors_data))
  end

  def exit_app
    puts 'Goodbye!'

    exit
  end

  private

  def save_movies
    data = @movies.map(&:to_h)
    File.write('json/movies.json', JSON.dump(data))
  end

  def load_movies
    return unless File.exist?('json/movies.json')

    data = JSON.parse(File.read('json/movies.json'))
    data.map do |movie_data|
      Movie.new(
        movie_data['genre'],
        movie_data['author'],
        movie_data['label'],
        movie_data['source'],
        movie_data['publish_date']
      )
    end
  end
  # t0 here................Fatuma...........

  # added from here.............EVANS...........
  def save_sources
    data = @sources.map(&:to_h)
    File.write('json/sources.json', JSON.dump(data))
  end

  def load_sources
    return unless File.exist?('json/sources.json')

    data = JSON.parse(File.read('json/sources.json'))
    data.map { |source_data| Source.new(source_data['name']) }
  end
end
# to here.............EVANS...........
