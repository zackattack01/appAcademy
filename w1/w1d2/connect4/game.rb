require_relative 'player'
require_relative 'board'

class Game

  def initialize(p1, p2)
    @board = Board.new
    @player1 = p1
    @player2 = p2
    @player1.mark = "@"
    @player2.mark = "+"
    @turn = p1
  end

  def run
    board.display
    until over?
      play_turn

      system("clear")
      board.display

      change_turn
    end

    congrats
  end

  def play_turn
    board.drop_disc(prompt_move, turn.mark)
  end

  def prompt_move
    puts "Player #{@turn.mark}, where do you want to move? (1..7)"
    move_col = turn.get_move
    if board.col_full? move_col
      puts "That column is full already :("
      prompt_move
    else
      move_col
    end
  end

  def change_turn
    self.turn = turn == player1 ? player2 : player1
  end


  def over?
    board.winner || board.filled?
  end

  def congrats
    winner = board.winner == nil ? "Nobody" : board.winner
    puts "Congrats #{winner}!"
  end

  private 
  
    attr_accessor :turn
    attr_reader :board, :player1, :player2
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new(HumanPlayer.new, ComputerPlayer.new)
  game.run
end