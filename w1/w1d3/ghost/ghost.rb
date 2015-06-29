require_relative 'player'

class Ghost
  DICTIONARY_PATH = "dictionary.txt"

  def initialize
    @fragment = ''
    @dictionary = File.readlines(DICTIONARY_PATH).map(&:chomp)
    @players = []
  end

  def run_game
    number_of_players = prompt_for_players
    prompt_for_names(number_of_players)
    run_single_game until players.length == 1
    system("clear")
    print_winner
  end

  def run_single_game
    run_round until game_over?
    print_game_loser
    remove_loser
  end

  def run_round
    play_turn until round_over?
    print_round_loser
    add_loss
    display_losses
    clear_fragment
  end

  private

    def add_loss
      previous_player.losses += 1
    end

    def add_letter(move)
      fragment << move
    end

    def check_dictionary(check)
      dictionary.any? do |word|
        word.start_with? check
      end
    end

    def clear_fragment
      @fragment = ''
    end

    def current_player
      players[0]
    end

    def display_losses
      players.each do |player|
        puts "#{player.name}: #{"GHOST"[0...player.losses]}"
      end
    end

    def end_turn
      system("clear")
      puts fragment
      next_player!
    end

    def game_loser
      players.select { |player| player.losses == 5 }.first
    end

    def game_over?
      players.any? { |player| player.losses == 5 }
    end

    def next_player!
      players.rotate!
    end

    def play_turn
      move = current_player.prompt_move
      until valid_play?(move)
        puts "Please choose a valid letter"
        move = current_player.prompt_move
      end

      add_letter(move)
      end_turn
    end

    def previous_player
      players[-1]
    end

    def print_game_loser
      puts "#{game_loser.name}, you lose the game!"
    end

    def print_round_loser
      puts "#{previous_player.name}, you lose this round!"
    end

    def print_winner
      puts "#{players.first.name} wins!"
    end

    def prompt_for_names(number_of_players)
      (1..number_of_players).each do |player|
        puts "What is the name of player #{player}?"
        name = gets.chomp
        players << Player.new(name)
      end
    end

    def prompt_for_players
      puts "How many players would you like?"
      gets.chomp.to_i
    end

    def remove_loser
      players.delete(game_loser)
    end

    def round_over?
      dictionary.include?(fragment)
    end

    def valid_play?(move)
      check = fragment + move

      move =~ /[a-z]/         &&
      move.length == 1        &&
      check_dictionary(check)
    end

    attr_reader :players, :fragment, :dictionary
end

if __FILE__ == $PROGRAM_NAME
  game = Ghost.new
  game.run_game
end