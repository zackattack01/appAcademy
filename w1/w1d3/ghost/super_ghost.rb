require_relative 'ghost'

class SuperGhost < Ghost

  def add_letter(move, position)
    case position
    when 1
      fragment.prepend(move)
    when 2
      fragment << move
    end
  end

  def check_dictionary(check)
    dictionary.any? do |word|
      word.include? check
    end
  end

  def play_turn
    move = current_player.prompt_move
    input = current_player.prompt_input
    until valid_play?(move, input)
      puts "Please choose a valid letter"
      move = current_player.prompt_move
      puts "Which end of the word?"
      input = current_player.prompt_input
    end

    add_letter(move, input)
    end_turn
  end

  def valid_play?(move, position)
    to_check = case position
               when 1
                 move + fragment
               when 2
                 fragment + move
               end

    move =~ /[a-z]/         &&
    move.length == 1        &&
    check_dictionary(to_check)
  end
end

if __FILE__ == $PROGRAM_NAME
  game = SuperGhost.new
  game.run_game
end