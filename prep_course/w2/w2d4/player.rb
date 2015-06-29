class HumanPlayer
  attr_reader :mark
  
  def initialize
  end
  
  def mark= (mark)
    @mark = mark
    puts "You are #{mark.to_s}"
  end

  def prompt_move(board)
    board.print_all
    print "#{mark}'s Turn: "
    pos = gets.chomp.split(" ").map { |num| num.to_f - 1 }
    if pos.all?{ |x| (0..2).cover?(x) && x.round == x } && board.empty?(pos)
      pos
    else
      puts "Please choose a valid empty space"
      prompt_move(board)
    end
  end

end


class ComputerPlayer
  attr_reader :mark
  
  def initialize
  end
  
  def mark= (mark)
    @mark = mark
  end

  def prompt_move(board)
    board.print_all
    print "#{mark}'s Turn: "
    pos = comp_ai(board)
    print "#{pos[0] + 1} "
    sleep 0.3
    puts pos[1] + 1
    pos 
  end

  

  private

    def select_diagonals(board, pos)
      diagonals_to_check = []
      if [[0,0], [1,1], [2,2]].include? pos
         diagonals_to_check << board.diagonals[0]
      end
      if [[0,2], [1,1], [2,0]].include? pos
        diagonals_to_check << board.diagonals[1]
      end
      diagonals_to_check
    end

    def comp_ai(board)
      spot_found = nil
      board.grid.each_with_index do |row, row_i|
        row.each_with_index do |spot, col_i|
          pos = [row_i, col_i]
          next unless board.empty?(pos)
          rows_to_check = [board.grid[row_i], board.grid.transpose[col_i]]
          select_diagonals(board, pos).each{ |diag| rows_to_check << diag }
          rows_to_check.each do |row|
            spot_found = pos if board.winning_spot?(@mark, row)  
          end
        end
      end
      spot_found.nil? ? board.blank_space : spot_found
    end

end
