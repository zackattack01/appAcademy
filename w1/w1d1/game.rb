class Game

  def initialize(match_number, rows, turn_max, bombs)
    @match_number = match_number
    @rows = rows
    @turn_max = turn_max
    @board = Board.new(rows, match_number, bombs)
    @guesses = []
    @turns = 0
  end

  def play
    board.render(true)
    sleep(1)
    system("clear")

    play_turns
    finish_game
  end

  def play_turns
    catch :bomb do
      until over?
        board.render(false)
        get_guesses
        end_turn
        sleep(2)
        system("clear")
      end
    end
  end

  def prompt_guess
    pos = []
    loop do
      puts "Please enter the position of a card (eg. 1, 2)"
      pos = gets.chomp.split(',')
      break unless invalid_pos?(pos)
    end
    pos.map { |n| n.to_i - 1 }
  end

  def end_turn
    check_guesses
    self.turns = turns + 1
    guesses.clear
  end

  def over?
    turns == turn_max || board.all_face_up?
  end

  def get_guesses
    match_number.times do
      pos = prompt_guess
      if board[*pos].bomb?
        puts "BOOM!"
        throw :bomb
      end
      make_guess(pos)
      guesses << pos
    end
  end

  def check_guesses
    if guesses.map { |guess| board[*guess].value }.uniq.length > 1
      board.flip_guesses(guesses)
      puts "no match!"
    else
      puts "you found a match!"
    end
  end

  def invalid_pos?(pos)
    if pos.length == 2 && pos.all? { |x| x =~ /[1-#{rows}]/ }
      return board[*pos.map { |x| x.to_i - 1 }].face_up?
    end

    true
  end

  def make_guess(pos)
    board[*pos].flip
    board.render(false)
    board[*pos]
  end

  def finish_game
     puts board.all_face_up? ? "You Won!" : "You Lost :("
  end

  private

    attr_accessor :turns
    attr_reader :match_number, :rows, :turn_max, :board, :guesses
end


if __FILE__ == $PROGRAM_NAME
  
  require_relative 'board'
  require_relative 'card'

  memory_game = Game.new(2,6,10,4)
  memory_game.play

end
