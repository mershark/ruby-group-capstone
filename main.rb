require './app'
require_relative 'menu'

response = App.new

def prompt(response)
  loop do
    display_menu
    option = gets.chomp.to_i
    break if option.zero?

    handle_option(option, response)
  end
end

prompt(response)





