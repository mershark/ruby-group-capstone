require 'json'

class App
  def initialize
    # Initialize collections for various item types
    @books = []
    @music_albums = recover_album || []
    @movies = [] 
    @games = []
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
