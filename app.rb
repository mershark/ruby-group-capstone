require_relative 'game'
require_relative 'author'
require_relative 'item'
require 'json'


class App
  def initialize
    # Initialize collections for various item types
    @books = []
    @music_albums = []
    @movies = []
    @games = []
    @authors = []
    load_data
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

  def add_game
    puts 'Enter the publish date of the game:'
    publish_date = gets.chomp

    puts 'Is the game archived? (true/false):'
    archived = gets.chomp.downcase == 'true'

    puts 'Is the game multiplayer? (true/false):'
    multiplayer = gets.chomp.downcase == 'true'

    puts 'Enter the last played at date of the game:'
    last_played_at = gets.chomp

    puts 'Enter the author name:'
    author_name = gets.chomp
    first_name, last_name = author_name.split
    author = Author.new(first_name, last_name) # Create a new Author object

    game = Game.new(publish_date, archived, multiplayer, last_played_at, author)
    @games << game
    @authors << author # Add the new author to the authors array

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

  # Preserve data
  def get_data(file_name)
    if File.exist?("json/#{file_name}.json")
      File.read("json/#{file_name}.json")
    else
      empty_json = [].to_json
      File.write("json/#{file_name}.json", empty_json)
      empty_json
    end
  end

  # load data
  def load_data
    games = JSON.parse(get_data('games'))

    games.each do |game|
      @games << Game.new(game['publish_date'], game['archived'], game['multiplayer'], game['last_played_at'],
                         game['author'])
    end
  end

  def exit_app
    puts 'Exiting the Catalog App. Goodbye!'

    update_games = []
    @games.each do |game|
      update_games << { 'publish_date' => game.publish_date, 'archived' => game.archived,
                        'multiplayer' => game.multiplayer, 'last_played_at' => game.last_played_at }
    end

    File.write('json/games.json', JSON.generate(update_games))
    exit
  end
end
