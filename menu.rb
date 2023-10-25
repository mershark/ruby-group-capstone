def display_menu
  options = {
    '1' => 'List all books',
    '2' => 'List all music albums',
    '3' => 'List all movies',
    '4' => 'List of games',
    '5' => 'List all genres (e.g \'Comedy\', \'Thriller\')',
    '6' => 'List all labels (e.g \'Gift\', \'New\')',
    '7' => 'List all authors (e.g \'Stephen King\')',
    '8' => 'List all sources (e.g \'From a friend\', \'Online shop\')',
    '9' => 'Add a book',
    '10' => 'Add a music album',
    '11' => 'Add a movie',
    '12' => 'Add a game',
    '0' => 'Exit App'
  }

  options.each do |index, string|
    puts "#{index} - #{string}"
  end
  puts ''
end

def handle_option(option, response)
  actions = {
    1 => :list_books,
    2 => :list_music_albums,
    3 => :list_movies,
    4 => :list_games,
    5 => :list_genres,
    6 => :list_labels,
    7 => :list_authors,
    8 => :list_sources,
    9 => :add_book,
    10 => :add_music_album,
    11 => :add_movie,
    12 => :add_game,
    0 => :exit_app
  }

  action = actions[option]

  if action
    execute_action(action, response) else
                                       handle_invalid_option
  end
end

def execute_action(action, response)
  response.send(action)
end

def handle_invalid_option
  puts 'Invalid option. Please choose a valid option.'
end
