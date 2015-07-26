
class Hangman
    
  attr_reader :turns_taken, :guessing_player, :checking_player
  
  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    setup_game
  end
  
  
  def play
    until won?
      display = checking_player.check_guess(guessing_player.guess)
      guessing_player.handle_guess_response(display)
      @turns_taken += 1
    end
    game_over
  end
  
  def setup_game
    guessing_player.receive_secret_length(checking_player.pick_secret_word)
    @turns_taken = 0
  end
  
  def game_over
    puts "The secret word was #{guessing_player.display.join}!"
    puts "Guessed in #{turns_taken} turns!"
  end
  
  
  def won?
    return !guessing_player.display.include?("_")
  end
end

class ComputerPlayer
  DICTIONARY = File.read("../../w2/w2d5/dictionary.txt").chomp.split("\n")
  attr_reader :display, :words_remaining, :last_guess, :secret_word
  
  def receive_secret_length(len)
    @display = Array.new(len, "_")
    @words_remaining = generate_words_remaining(len)
  end
  
  def generate_words_remaining(len)
    DICTIONARY.select { |word| word.length == len }
  end
  
  def pick_secret_word
    @secret_word = DICTIONARY.sample.split('')
    secret_word.length
  end
 
  
  def check_guess(guess)
    indices = []
    @secret_word.each_with_index do |char, idx| 
      indices << idx if guess.downcase == char
    end
    
    indices
  end
  
  
  def handle_guess_response(indices)
    @display.map!.with_index do |x, idx| 
      indices.include?(idx) ? last_guess : x 
    end
    indices.empty? ? filter_after_incorrect : filter_words_remaining(indices)
  end
  
  def guess
    @last_guess = find_most_common_letter
  end
  
  private
  
  def find_most_common_letter
    letter_count = Hash.new(0)
    words_remaining.each do |word|
      word.each_char do |char|
        letter_count[char] += 1 unless display.include?(char)
      end
    end
    raise "Word isn't present in dictionary" if letter_count.empty?
    letter_count.to_a.sort_by { |el| el[1] }[-1][0]
    
  end
  
  def filter_words_remaining(indices)
    @words_remaining.reject! do |word| 
      indices.any? { |idx| word[idx] != last_guess }
    end
  end
  
  def filter_after_incorrect
    @words_remaining.reject! do |word|
      word.include?(last_guess)
    end
  end 
end

class HumanPlayer
    
  attr_reader :secret_word, :display
  
  def initialize
    @guesses_received = []
    @guesses_made = []
  end
  
  def pick_secret_word
    print "Think of a secret word. How many letters long is it? "
    gets.chomp.to_i
  end
  
  def receive_secret_length(len)
    @display = Array.new(len, "_")
    puts "The secret word is #{len} letters long"
  end
  
  def handle_guess_response(indices)
    print "Secret word: "
    @display.map!.with_index { |x, idx| indices.include?(idx) ? @last_guess : x }
    puts @display.join
  end
  
  
  def check_guess(guess)
    @guesses_received << guess unless @guesses_received.include?(guess)
    puts "Where does this letter occur in your word? #{guess}"
    print "Enter the indices separated by commas: "
    gets.chomp.split(',').map(&:to_i)
  end
  
  def guess
    @last_guess = gets.chomp
    @last_guess
  end
end


hangman = Hangman.new(ComputerPlayer.new, ComputerPlayer.new)
hangman.play