# mastermind.rb
# A Mastermind game.
# Usage: 'ruby mastermind.rb'
  
require 'byebug'

COLORS = { 'B' => :Blue,
           'G' => :Green,
           'O' => :Orange,
           'P' => :Purple,
           'R' => :Red,
           'Y' => :Yellow
}

# Plays a game of Mastermind.
class Game
  LIMIT = 10
  
  # Entry point.
  def self.run
    Game.new.game_loop
  end
  
  attr_accessor :turn, :last_guess

  def initialize
    @secret = Code.random
    @turn = 1
    @last_guess = []
  end
  
  # Main game loop.
  def game_loop
    welcome
    catch :quit do 
      while turn <= LIMIT do
        expect_guess
        if won?
          win_state
          return
        end
  
        give_feedback 
        self.turn += 1
      end
      out_of_moves
    end
  end

  # Prints a welcome message to the console.
  def welcome
    puts 'Welcome to mastermind, the classic code-breaking game.'
    puts "Possible peg colors are (R)ed, (O)range, (Y)ellow, (B)lue," +
                                             " (G)reen, and (P)urple"
    puts 'Enter "q" to quit at any time.'
  end
  
  # Returns true if the user has guessed the secret code.
  def won?
    @secret.exact_matches(last_guess) == 4
  end
  
  # Returns true if the user's input was correctly formatted.
  def valid_input?(input)
    return false unless input.length == 4
    
    input.split('').all? { |peg| COLORS.keys.include? peg }
  end
  
  # Prints the correct near and exact matches for the last guess.
  def give_feedback
    print 'Matches: '
    puts 'Black ' * @secret.exact_matches(last_guess) + \
         'White ' * @secret.near_matches(last_guess)
  end
  
  # Collects a guess from the user.
  def expect_guess
    print "Guess ##{turn}. What's your code? "
    input = gets.chomp
    throw :quit if input == "q"
    
    if valid_input? input
      self.last_guess = Code.parse(input)
      puts "Your guess was #{last_guess}."
    else
      puts "Please enter 4 valid colors."
      expect_guess
    end
  end
  
  def win_state
    puts "You won! The secret code is #{@secret}."
    puts "Found in #{@turn} turns."
  end
  
  def out_of_moves
    puts "Out of moves!"
    puts "The code was #{@secret}."
  end


end

# A single Mastermind code, representing 4 colored pegs and their positions.
class Code
  PRINT_COLORS = { :Red => "91", :Green => "92", :Yellow => "93", 
            :Blue => "94", :Purple => "95", :Orange => "38;5;208"}

  attr_accessor :pegs
  
  # Creates a Code containing the specified colors.
  def initialize(code)
    @pegs = code
  end
  
  # Returns a randomly-created Code.
  def self.random
    code = 4.times.map { COLORS.values.sample }
    Code.new code
  end
  
  
  # Returns the Code corresponding to the input string's characters.
  def self.parse(input)
    code = input.split('').map { |peg| COLORS[peg] }
    Code.new code
  end
  
  # Returns the number of exact matches (same color, same position).
  def exact_matches(guess)
    pegs.zip(guess.pegs).count { |a, b| a == b }
  end

  # Returns the number of near matches (same color, different position).
  def near_matches(guess)
    near_matches = 0
    COLORS.values.each do |color|
      near_matches += [pegs.count { |x| x == color }, 
                      guess.pegs.count { |x| x == color }].min
    end
    
    near_matches - exact_matches(guess)
  end
  
  def to_s
    pegs.map { |color| "\033[#{PRINT_COLORS[color]}m#{color.to_s}\033[0m" }.join ' '
  end

  
end

Game.run