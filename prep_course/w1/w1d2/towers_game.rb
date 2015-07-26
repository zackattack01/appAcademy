class Hanoi_tower
  
  ROD_MAP = { 'a' => 0, 'b'=> 1, 'c' => 2 }
  RODS_INVERTED = ROD_MAP.invert

  attr_accessor :n, :rods, :col_headers, :empty_spot, :target
  
  def initialize
    welcome_player  
  end

  def welcome_player
    puts "Welcome to our Tower of Hanoi game!"
    sleep 1
    puts "Let's begin!"
  end

  def get_disc_number
    puts "How many discs do you want to start with?"
    self.n = gets.chomp.to_i
    case
    when n<=1
      puts "You'll need more than that"
      get_disc_number 
    when n < 20
      puts "Great, we will start with #{n} discs."
      load_discs
    else
      puts "Please choose a number that won't break my formatting"
      get_disc_number
    end
    load_discs
  end

  ## figures out how wide the cols will need to be (and the empty spaces in them to keep their 
  ## form when printing), then creates the discs from parenthesis and underscores 
  def load_discs
    a = [1]
    (n - 1).times{ |i| a << (a.last + 2)}
    self.empty_spot = " " * (a.last + 2)
    a.map! { |disc_num| "(#{"_"*disc_num})".center((empty_spot.length), ' ') }
    self.rods = [a, [], []]
    self.col_headers = %w{ a b c }.map { |label| 
      label.center((empty_spot.length), ' ') }.join
    set_target

  end

  def set_target
    self.target = rods[0].dup
  end

  ## pumps in some empty spaces to maintain form
  def format_rods
    rods.each {|rod| rod.unshift(empty_spot) until rod.length == n}
  end

  ## clears screen then transposes the rods 
  ## so we can print them vertically
  def print_rods
    puts "\033[H\033[2J#{col_headers}"
    
    (0..n).each do |col|
      grid_row = []
      rods.each{|rod| rod.each_with_index {|disc, disc_idx| grid_row << disc if disc_idx == col }}
      puts grid_row.join
    end
  end
  
  def print_error(error)
    format_rods
    print_rods
    puts error
  end

  
  
  def run_game_loop
    get_disc_number
    while rods[1..2].none?{ |rod| rod == target }
      print_rods
      clean_rods
      
      from = get_from
      next unless valid_from_input?(from)
      
      to = get_to
      next unless valid_to_input?(to) 
      next unless valid_move?(from, to)
      
      rods[to].unshift(rods[from].shift)
      format_rods
    end
    game_over
    
  end

  def game_over
    print_rods
    puts "Congrats, you've won! (finally)"
    sleep 0.5
    prompt_again
  end

  def get_from
    puts "Pick a peg from rods a, b, or c"
    ROD_MAP[gets.chomp.to_s]
  end

  def get_to
    puts "Place the peg on..."
    ROD_MAP[gets.chomp.to_s]
  end

  def valid_from_input?(from)
    if from.nil? 
      print_error("Invalid rod")
    elsif rods[from].empty?
      print_error("Pick again, #{RODS_INVERTED[from]} is empty")
    else
      return true
    end
    false
  end

  def valid_to_input?(to)
    if to.nil? 
      print_error("Invalid rod")
      return false
    end
    true
  end

  def valid_move?(from, to)
    if (rods[to]!=[] && 
       (rods[from].first.count("_") > rods[to].first.count("_")))
       print_error("Try again, the disc underneath is too small")
       return false 
    end
    true
  end


  def clean_rods
    rods.map! { |rod| rod.select{ |row| row != empty_spot } }
  end


  def prompt_again
    puts "Would you like to play again? (y/n)"
    response = gets.chomp
    case response
    when "y"
      puts "Great!" 
    when "n"
      puts "As if"
    else
      puts "I'll take that as a yes"
    end
    @game.run_game_loop
  end

  

end
@game = Hanoi_tower.new
@game.run_game_loop