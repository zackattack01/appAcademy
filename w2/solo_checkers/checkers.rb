require_relative 'board'
require_relative 'player'
class Checkers

  def initialize
    @board = Board.new
    @players = [Player.new(@board), Player.new(@board)]
    set_player_colors
  end

  def run
    system("clear")
    puts "SpaceBar- select a piece and add an intermediate step"
    puts "Enter- press on the final step of your intended move"
    sleep(2)
    puts "d- to remove a step from your intended path or deselect a piece"
    puts "q- quit at any time"
    sleep(2)
    puts "press enter to begin"
    gets.chomp
    board.display
    take_turn until game_over?
  end

  private

    attr_reader :board, :players

    def set_player_colors
      @players.first.color = :white
      @players.last.color = :black
    end

    def take_turn
      players.first.get_moveset
      players.rotate!
      puts "#{players.first.color}'s turn"
    end

    def game_over?
      board.winner != nil
    end

end


if __FILE__ == $PROGRAM_NAME
  game = Checkers.new
  game.run
end