require './classes/item' # added this.............................
require './classes/book' # added this.............................
require './classes/label' # added this.............................
require 'json'
require './modules/book_label_storage' # added this.............................

class App
  include JsonStorage # added this.............................
  def initialize
    # Initialize collections for various item types
    @books = []
    @music_albums = []
    @movies = []
    @games = []
    @labels = [] # added this.............................

    load_from_json # added this..............................
  end

  # added from here..................................
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
  # to here...................................................

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
