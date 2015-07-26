require 'colorize'

class Piece

  SLIDE_DELTAS = {
    :white => [[-1, 1], [-1, -1]],
    :black => [[1, 1], [1, -1]]
  }

  JUMP_DELTAS = {
    :white => [[-2, 2], [-2, -2]],
    :black => [[2, 2], [2, -2]],
  }

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, king = false)
    @color = color
    @board = board
    @king = king
  end

  def to_s
    if king?
      if color == :white
        "\u269B ".colorize(color) 
      else
        "\u269B ".colorize(:red)
      end
    elsif color == :black
      "\u26AB "
    else
      "\u26AA "
    end
  end

  def king?
    king
  end

  def empty?
    false
  end

  def dup(board)
    self.class.new(color, board, king)
  end

  def perform_moves(moveset)
    if valid_move_sequence?(moveset)
      perform_moves!(moveset) 
      true
    else
      false
    end
  end
    
  def valid_move_sequence?(moveset)
    begin
      test_board = board.deep_dup
      test_me = test_board[pos]
      test_me.perform_moves!(moveset)
    rescue InvalidSequenceError
      puts "Invalid move sequence, try again"
      return false
    end

    true
  end

  def maybe_promote
    if (color == :white && pos[0] == 0) || (color == :black && pos[0] == 7)
      @king = true
    end 
  end

  private

    attr_reader :king

    def perform_slide(destination)
      return false if (destination[0] - pos[0]).abs > 1
      if valid_move?(destination)
        board[destination], board[pos] = board[pos], board[destination]
        self.pos = destination
        maybe_promote
        true
      else
        false
      end
    end

    def perform_jump(destination)
      return false unless valid_move?(destination)

      opp_delta = baby_delta(delta_of(destination))
      if piece_to_jump?(opp_delta)
        board[destination], board[pos] = board[pos], board[destination]
        board[next_pos(opp_delta)] = board.sentinel
        self.pos = destination
        maybe_promote
        true
      else
        false
      end
    end

    def check_single_move(destination, part_of_sequence = false)
      if part_of_sequence || (destination[0] - pos[0]).abs > 1
        raise InvalidSequenceError unless perform_jump(destination)
      else
        unless perform_slide(destination) || perform_jump(destination)
          raise InvalidSequenceError 
        end
      end
    end

    def my_immediate_moves
      if king?
        deltas = (SLIDE_DELTAS.values + JUMP_DELTAS.values).flatten(1)
      else
        deltas = SLIDE_DELTAS[color] + JUMP_DELTAS[color]
      end
      deltas.map { |delta| next_pos(delta) }
    end

    def next_pos(delta)
      pos.zip(delta).map { |pair| pair.inject(:+) }
    end

    def delta_of(destination)
      destination.zip(pos).map { |pair| pair.inject(:-) }
    end

    def baby_delta(delta)
      delta.map { |el| el / 2 }
    end

    def piece_to_jump?(delta)
      board[next_pos(delta)].color == board.other_color(color)
    end

    def valid_move?(destination)
      my_immediate_moves.include?(destination) &&
      board.on_board?(destination)             && 
      board.empty?(destination)
    end

    protected

      def perform_moves!(moveset)
        if moveset.count == 1 
          check_single_move(moveset.first)
        else
          moveset.each do |move|
            check_single_move(move, true)
          end
        end 
      end
end

class EmptySquare

  def empty?
    true
  end

  def to_s
    "  "
  end

  def color
    false
  end

  def dup(board)
    self.class.new
  end

end

class InvalidSequenceError < StandardError
end