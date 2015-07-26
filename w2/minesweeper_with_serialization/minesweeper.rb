require_relative 'board'
require 'yaml'

class MineSweeper

  def run
    get_board
    start_game

    until game_won? || bomb_hit?
      input = get_input
      if input == "s"
        board.set_accumulated_time
        save_game
        return
      elsif valid_input?(input)
        take_turn(input)
      end
    end
    end_game  
  end

  def start_game
    puts "Enter 's' before any turn to save and quit."
    board.reset_timer
    @bomb_hit = false
  end

  def update_leaderboard
    stats = File.readlines("leaderboard.txt").map do |stat| 
      stat.chomp.split[1].to_i 
    end
    stats << board.accumulated_time

    File.open("leaderboard.txt", 'w') do |f|
      stats.sort[0..9].each_with_index do |stat, idx|
        f.puts "#{idx + 1}) #{stat} seconds"
      end
    end
  end

  def end_game
    if game_won?
      print_congrats
      board.set_accumulated_time
      display_time_played
      update_leaderboard
    else
      print_bomb
    end
  end

  def display_time_played
    puts "#{board.accumulated_time} seconds"
  end

  def valid_input?(input)
    action, row, col = input.split(",")
    if [action, row, col].any? { |inp| inp.nil? }            ||
       [row, col].any? { |x| !(x =~ /[0-8]/) }               ||
       ["f", "r"].none? { |char| char == action.downcase }
       false
     else
       true
    end
  end

  def get_board
    puts "Would you like to (l)oad or start a (n)ew game?"
    case gets.chomp.downcase
    when "l"
      @board = YAML.load_file('state.yml')
    when "n"
      @board = Board.new
    end
    board.render
  end


  def print_congrats
    system("clear")
    puts "Congrats you've won!"
  end

  def print_bomb
    system("clear")
    puts "BOOM"
  end

  def save_game
    File.open('state.yml', 'w') { |f| f.puts @board.to_yaml }
  end

  def get_input
    puts "(F)lag or (R)eveal? and position. (eg. R, 4, 2)"
    gets.chomp
  end

  def take_turn(input)
    action, row, col = input.split(",")

    if action.downcase == "f"
      board.flag([row.to_i, col.to_i])
    elsif action.downcase == "r"
      reveal = board.reveal([row.to_i, col.to_i])
      @bomb_hit = true if reveal.nil?
    end

    system("clear")
    board.render
  end

  def bomb_hit?
    @bomb_hit
  end

  def game_won?
    board.solved?
  end


  private

    attr_reader :board, :bomb_hit
end

if __FILE__ == $PROGRAM_NAME
  m = MineSweeper.new
  m.run
end
