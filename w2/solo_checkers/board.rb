require_relative 'piece'

class Board

	attr_accessor :selected_piece
	attr_reader :cursor, :sentinel

	def initialize(need_blank_grid = false)
		@sentinel = EmptySquare.new
		generate_blank_grid
		set_pieces unless need_blank_grid
		set_positions 
	end

	def [](pos)
		row, col = pos
		@grid[row][col]
	end

	def []=(pos, piece)
		row, col = pos
		@grid[row][col] = piece
	end

	def display(moveset = [])
		system("clear")
		8.times do |row_idx|
			to_print = []
			black_before = row_idx.even?
			8.times do |col_idx|
				black_before = !black_before
				pos = [row_idx, col_idx]
				color = black_before ? :black : :red
				color = :yellow if moveset.include?(pos)
				color = :green if pos == cursor
				to_print << self[pos].to_s.colorize(background: color)
			end
			puts to_print.join
		end
	end

	def winner
		pieces = grid.flatten.select { |square| square.color }.map(&:color)
		pieces.uniq.count == 1 ? pieces.first : nil
	end

	def on_board?(pos)
		pos.all? { |x| x.between?(0, 7) }
	end

	def empty?(pos)
		self[pos].empty?
	end

	def move_cursor(delta)
		next_cursor = cursor.zip(delta).map { |pair| pair.inject(:+) }
		@cursor = next_cursor if on_board?(next_cursor)
	end

	def deep_dup
		next_board = self.class.new(true)
		next_board._grid = grid.map do |row|
			row.map { |square| square.dup(next_board) }
		end
		next_board.set_positions

		next_board
	end

	def other_color(color)
		color == :white ? :black : :white
	end

	private

		attr_reader :grid

		def generate_blank_grid
			@grid = Array.new(8) { Array.new(8) { sentinel } }
		end

		def set_pieces
			set_piece_set(:black)
			set_middle_squares
			set_piece_set(:white)
			@cursor = [4, 4]
		end

		def set_piece_set(color)
			skip_first, row_start = color == :black ? ["odd?", 0] : ["even?", 5]
			3.times do |row_idx|
				piece_before = row_idx.send(skip_first)
				8.times do |col_idx|
					pos = [row_idx + row_start, col_idx]
					piece_before = !piece_before
					self[pos] = piece_before ? sentinel : Piece.new(color, self)
				end
			end
		end

		def set_middle_squares
			3.upto(4) do |row_idx|
				8.times { |col_idx| self[[row_idx, col_idx]] = sentinel }
			end
		end

		protected

			def _grid=(new_grid)
				@grid = new_grid
			end

		def set_positions
			grid.each_with_index do |row, row_idx|
				row.each_with_index do |square, col_idx|
					next if square.empty?
					square.pos = [row_idx, col_idx]
				end
			end
		end

end


if __FILE__ == $PROGRAM_NAME
	b = Board.new
	b.display
end