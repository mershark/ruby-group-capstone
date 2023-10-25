require_relative 'item'
require_relative 'author'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :author

  def initialize(publish_date, archived, multiplayer, last_played_at, author)
    super(publish_date, archived)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @author = author
  end

  def can_be_archived?
    super && last_played_over_two_years_ago?
  end

  private

  def last_played_over_two_years_ago?
    last_played_date = Date.parse(@last_played_at)
    current_date = Date.today
    years_difference = current_date.year - last_played_date.year

    puts "Last played date: #{last_played_date}"
    puts "Current date: #{current_date}"
    puts "Years difference: #{years_difference}"

    years_difference >= 2
  end
end
