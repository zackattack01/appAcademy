require_relative 'player'

class Game
  attr_accessor :players
  
  def initialize(player1, player2)
    self.players = [player1, player2]
    run_game
  end
    
  def run_game
	  board = Board.new
	  give_marks
	  turn=[0,1].sample
	  puts "#{@players[turn].mark.to_s} starts"
	  while (board.won? == false) && (board.tie? == false)
      pos = players[turn].prompt_move(board)
      board.place_mark(pos, players[turn].mark)
      if board.won?
      	board.print_all
      	puts "#{board.winner} wins" 
      elsif board.tie?
      	board.print_all
      	puts "Tie Game" 
      end
      turn = turn == 1 ? 0 : 1
		end
	end

  def give_marks
   	 marks= [:X, :Y].shuffle
   	 players.each_with_index do |player, idx| 
	  	 player.mark = marks[idx] 
	   end	
  end

end


class Board
  attr_reader :grid, :winner

  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def empty?(pos)
    self[*pos].nil? 
  end
  
  def place_mark(pos, mark)
    self[*pos] = mark
  end

  def diagonals
    [[self[0,0], self[1,1], self[2,2]], 
     [self[0,2], self[1,1], self[2,0]]]
  end
  
  def won?
    [grid, grid.transpose, diagonals].each do |rowset|
      if rowset.any? {|row| row.uniq.count == 1 && row[0] != nil } 
        @winner =
        rowset.select { |row| row.uniq.count == 1 && row[0] != nil }[0][0]
        return true
      end
    end
    false
  end
  
  def print_all
  	puts "  1 2 3"
    grid.each_with_index do |row, idx| 
      puts "#{idx+1} #{row.map{ |spot| spot == nil ? "  " : "#{spot.to_s} " }.join}"
    end
  end
  
  def tie?
    grid.flatten.none?{ |x| x == nil }
  end
  
  def winning_spot?(sym, row)
    row.count(sym) == 2 ? true : false
  end
  
  def blank_space
    blanks = []
    (0..2).each{ |x| (0..2).each{ |y| blanks << [x, y] if empty?([x,y]) } }
    blanks.sample
  end
  
end

player1 = HumanPlayer.new
player2 = ComputerPlayer.new

game = Game.new(player1, player2)