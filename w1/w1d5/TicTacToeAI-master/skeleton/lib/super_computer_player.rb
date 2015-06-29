require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    board = game.board
    board_node = TicTacToeNode.new(board, mark)
    winner = board_node.children.select { |child| child.winning_node? mark }
    unless winner.empty?
      winner[0].prev_move_pos
    else
      not_losing = board_node.children.reject { |child| child.losing_node?(mark) }
      raise "I'm a bad loser" if not_losing.empty?
      not_losing[0].prev_move_pos
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
