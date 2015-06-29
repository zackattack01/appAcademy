require_relative 'board'

class Game
  def initialize(board)
    @board = board
  end

  def run
    until solved?
      system("clear")
      board.render
      move = nil
      move = prompt_move while move.nil?

      make_move(move)
    end

    congrats
  end

  def prompt_move
    puts "What's your next move? eg. row, col, and number. (1-9)"
    r, c, v = gets.chomp.split(',').map(&:to_i)
    r, c = r - 1, c - 1

    move = [[r,c], v]
    valid_move?(move) ? move : nil
  end


  def congrats
    board.render
    puts "Nice work!"
  end

  def valid_move?(move)
    board[move[0]].given == false && [*1..9].include?(move[1])
  end

  def make_move(move)
    pos, v = move 
    board[pos] = v
  end

  def solved?
    board.valid_solution?
  end

  private

    attr_reader :board
end


if __FILE__ == $PROGRAM_NAME
  board = Board.from_file("puzzles/sudoku1.txt")
  game = Game.new(board)
  game.run
end