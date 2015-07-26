require 'io/console'

class Player
	ARROWS = {
              "\e[A" => [-1, 0],
              "\e[B" => [ 1, 0],
              "\e[C" => [ 0, 1],
              "\e[D" => [ 0,-1]
            }

  attr_accessor :color
  attr_reader :moveset

	def initialize(board)
		@board = board
	end

	def get_moveset
		@moveset = []
		handle_user_interaction
	end

	private
		attr_accessor :move_over
		attr_reader :board
		attr_writer :moveset

		def handle_user_interaction
			self.move_over = false
			action = nil
			until move_over
				action = get_movement
				board.move_cursor(ARROWS[action]) if ARROWS.keys.include?(action)
				abort("goodbye") if action == "q"
				if action == " "
					unless moveset.empty? && board[board.cursor].color != color
						moveset << board.cursor 
					end
				end
				moveset.pop if action == "d"

				if action == "\r"
					moveset << board.cursor
					next if moveset.count <= 1
					if board[moveset.first].perform_moves(moveset.drop(1))
						self.move_over = true
					else
						handle_user_interaction
					end
				end
				board.display(moveset)
			end
		end

		def get_movement
	    STDIN.echo = false
	    STDIN.raw!

	    input = STDIN.getc.chr
	    if input == "\e" then
	      input << STDIN.read_nonblock(3) rescue nil
	      input << STDIN.read_nonblock(2) rescue nil
	    end
	  ensure
	    STDIN.echo = true
	    STDIN.cooked!

	    return input
	  end
end