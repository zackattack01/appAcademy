require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :prev_move_pos, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return board.winner == other_player(evaluator)
    end
    if @next_mover_mark == evaluator
      return self.children.all? { |child| child.losing_node?(evaluator) }
    else
      return self.children.any? { |child| child.winning_node?(other_player(evaluator))}
    end
    false
  end

  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end
    if @next_mover_mark == evaluator
      return self.children.any? { |child| child.winning_node?(evaluator) }
    else
      return self.children.all? { |child| child.winning_node?(evaluator) }
    end
    false
  end

  def other_player(player)
    player ==  :x ? :o : :x
  end

  def duplicate_board(board)
    Board.new(@board.rows.map { |square| square.dup })
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    next_mark = @next_mover_mark == :x ? :o : :x
    board.rows.each_with_index do |row,i|
      row.each_with_index do |square,k|
        pos = [i, k]
        if board.empty? pos
          new_board = duplicate_board(@board)
          new_board[pos] = @next_mover_mark
          result << TicTacToeNode.new(new_board, next_mark, [i, k])
        end
      end
    end
    result
  end
  
end
