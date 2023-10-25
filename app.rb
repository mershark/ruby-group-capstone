require 'json'
require_relative 'classes/movie'
require_relative 'classes/source'

class App
  def initialize
    @books = []
    @music_albums = []
    @movies = load_movies || []
    @games = []
    @sources = load_sources || []
  end

  def list_books
    puts 'Listing all books:'
    # Implement code to list books here
  end

  def add_book
    puts 'Adding a book:'
    # Implement code to add a book here
  end

  def list_music_albums
    puts 'Listing all music albums:'
    # Implement code to list music albums here
  end

  def add_music_album
    puts 'Adding a music album:'
    # Implement code to add a music album here
  end

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
