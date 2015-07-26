POS_MAP = { :A => 0, :B => 1, :C => 2, :D => 3, :E => 4,
            :F => 5, :G => 6, :H => 7, :I => 8, :J => 9 }

class Game

  attr_reader :turn, :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    puts "Welcome to Battleship!"
  end

  def run_setup_phase
    setup_explanation
    [player1, player2].each { |player| player.setup_ships }
    play
  end

  def setup_explanation
    sleep 0.6
    puts "Please setup your fleet, you'll need one of each:".clear_screen_before
    sleep 0.5
    puts "Aircraft Carrier(6), Battleship(5), Submarine(4), Destroyer(3), " + 
                                                     "and Patrol Boat(2)"
    sleep 0.5
    puts "For each, input the length (1-6), the position of origin," + 
                                              " and the orientation"
    puts "(U)p, (D)own, (L)eft, or (R)ight"
    sleep 5.0
  end


  ## prompts an attack from each player and displays status
  ## repeatedly until there is a winner
  def play

    until won?
      play_turn
      display_status  
    end

    puts "Congrats #{winner}!"
  end


  ## sets each player's last move to a hash value of the attack => nil,
  ## to be set to :hit or :miss after receiving feedback
  def play_turn
    player1.last_move = { player1.get_attack => nil }
    player2.last_move = { player2.get_attack => nil }
    generate_attacks
  end

  ## takes each player's chosen attack and generates feedback
  ## and alters board structures as needed
  def generate_attacks
    [player1, player2].each_with_index do |player, idx|
      opp = (idx == 0 ? player2 : player1)
      pos = player.last_move.keys[0]
      if opp.board.hit?(pos)
        player.receive_hit_feedback(pos)
        opp.take_hit(pos)
      else
        player.receive_miss_feedback(pos)
      end
    end
  end

  
  
  
  ## prints count of each player's remaining ships followed by col headers and 
  ## each player's respective boards. rows are zipped for printing side by side
  def display_status
    puts ("Player 1: #{player1.board.count}   " +
         "Player 2: #{player2.board.count}").clear_screen_before
    puts "  ABCDEFGHIJ    ABCDEFGHIJ"
    player1.board.display.zip(player2.board.display).each do |row|
      puts row.join('  ')
    end
    puts "     #{printable_last_moves.join('          ')}" 
  end


  def printable_last_moves
    [player1, player2].map { |player| 
      player.last_move.values[0] == :hit ? "HIT".red : "MISS".water }
  end

  def won?
    [player1, player2].any? { |player| player.board.ships.empty? }
  end



  def winner
    player1.board.ships.count == 0 ? "Player 2" : "Player 1"
  end





end








class Board

  attr_accessor :grid, :ships

  def initialize
    @grid = Array.new(10) { Array.new(10) }
    @ships = []
  end

  def display
    display = []
    grid.each_with_index do |row, idx| 
      display << 
      "#{idx} #{row.map { |x| x.nil? || x == "#" ? "~".water : x }.join }" 
    end
    display
  end

  def display_for_setup
    puts ("eg. 4 A0 D will put a submarine in the top " + 
    "left corner pointing downwards (to A3)").clear_screen_before
    puts "  ABCDEFGHIJ"
    grid.each_with_index do |row, idx| 
      puts "#{idx} #{row.map { |x| x.nil? ? "~".water : x }.join }" 
    end
  end




  def hit?(pos)
    ships.any? { |ship| ship.spaces.include? pos }
  end

  def mark_hit(pos)
    self[*pos] = "X".red
  end

  def damage_ship(pos)
    damaged = ships.select do |ship| 
      ship.spaces.include? pos 
    end[0]
    damaged.hit_spot(pos) unless damaged.nil?
  end



  def mark_miss(pos)
    self[*pos] = "0".water
  end

  def add_ship(ship)
    ship.spaces.each do |space|
      self[*space] = '#'
    end
    ships << ship
  end

  def remove_sunken_ships
    ships.reject! { |ship| ship.sunk? }
  end

  def count
    ships.count
  end




  ## row and col switched for playability 
  ## eg A7 rather than 7A
  def [](row, col)
    grid[col][row]
  end

  def []=(row, col, mark)
    grid[col][row] = mark
  end


  def spaces_available?(spaces)
    spaces.all? do |pos|
      in_range?(pos) && empty?(pos)
    end
  end

  def in_range?(pos)
    pos.all? { |coord| coord < 10 && coord >= 0 }
  end

  def empty?(pos)
    self[*pos].nil?
  end

end






class Ship

  attr_accessor :spaces

  def initialize(length, pos, orientation)
    @spaces = []
    generate_spaces(length, pos, orientation)
  end



  ## pushes all of the board spaces that would be 
  ## covered by a ship with the given parameters into @spaces
  def generate_spaces(length, pos, orientation)
    length.times do |t|
    @spaces << case orientation
               when "L"
                 [(pos[0] - t), pos[1]]
               when "R"
                 [(pos[0] + t), pos[1]]
               when "U"
                 [pos[0], (pos[1] - t)]
               when "D"
                 [pos[0], (pos[1] + t)]
               else
                ##figure out what to do here
                 return nil
               end
    end
  end


  def hit_spot(pos)
    spaces.delete(pos) if spaces.include? pos
  end


  def sunk?
    spaces.empty?
  end

end





class HumanPlayer

  attr_accessor :board, :last_move, :moves_used

  def initialize
    @board = Board.new
    @moves_used = []
  end

  ## continues prompting for acceptable ship parameters
  ## until all 5 have been initialized
  def setup_ships
    until board.ships.count == 5
      board.display_for_setup
      ship = Ship.new(*get_new_ship)
      if board.spaces_available?(ship.spaces)
        board.add_ship(ship) 
      else
        puts "Make sure all needed spaces are empty and in range"
      end
    end
    
    board.display_for_setup
    puts "^^YOUR FINAL SETUP^^"
  end


  def receive_hit_feedback(pos)
    last_move[pos] = :hit
    board.mark_hit(pos)
  end


  def take_hit(pos)
    board.damage_ship(pos)
    board.remove_sunken_ships
  end


  def receive_miss_feedback(pos)
    last_move[pos] = :miss
    board.mark_miss(pos)
  end


  def get_attack
    puts "Where would you like to attack?"
    attack = gets.chomp.split('')
    if already_attacked? attack
      puts "You've already attacked this space"
      get_attack
    elsif valid_attack? attack
      moves_used << attack
      map_pos(*attack)
    else
      puts "Not a valid attack"
      get_attack
    end
  end

  

    private

    def already_attacked?(attack)
      moves_used.include? attack
    end

    ## need to improve
    def valid_attack?(pos)
      pos.count == 2 && pos[0] =~ /[a-jA-J]/ &&
                        pos[1] =~ /[0-9]/
    end

  ##SHIPS = ["2 a0 r", "3 a1 r","4 a2 r","5 a3 r","6 a4 r"]
  ## next_ship = map_ship_input(SHIPS[board.count].split)
  ## validates user input and maps it to initialize and place new ships
    def get_new_ship
      print "Please add a ship: "
      next_ship = gets.chomp.split
      if next_ship.count != 3 
        puts "Not a valid number of arguments"
        get_new_ship
      else
        next_ship = map_ship_input(next_ship)
        if used_ship? next_ship
          puts "You already used this ship"
          get_new_ship
        else
          next_ship
        end
      end
    end

  
    ## turns user input into ships parameters,
    ## calls get_new_ship again if any aren't satisfactory 
    def map_ship_input(next_ship)
      len, pos, ornt = next_ship
      if len =~ /\D+/ 
        puts "Not a valid length"
        get_new_ship
      elsif ornt =~ /[^LRUD]/i
        puts "Not a valid orientation"
        get_new_ship
      else
        [len.to_i, map_pos(*pos.split('')), ornt.upcase]
      end
    end
    
    def map_pos(x, y)
      [POS_MAP[x.upcase.to_sym], y.to_i]
    end


    ## returns true if user has already initialized this type of ship
    def used_ship?(next_ship)
      board.ships.any? { |ship| ship.spaces.count == next_ship[0] }
    end


end





class ComputerPlayer

  attr_accessor :board, :last_move, :moves_used

  def initialize
    @board = Board.new
    @moves_used = {}
    @trails = []
  end

  ## tries random ship orientations and positions 
  ## until one works for each size
  def setup_ships
    ornts = %w{ R L U D }
    range = (0..9).to_a
    (2..6).each do |len|
      invalid_ship = true
      while invalid_ship
        ship = Ship.new(len, [range.sample, range.sample], 
                                            ornts.sample)
        if board.spaces_available?(ship.spaces)
          board.add_ship(ship) 
          invalid_ship = false
        end
      end
    end
  end


  def receive_hit_feedback(pos)
    last_move[pos] = :hit
    board.mark_hit(pos)
  end


  def take_hit(pos)
    board.damage_ship(pos)
    board.remove_sunken_ships
  end


  def receive_miss_feedback(pos)
    last_move[pos] = :miss
    board.mark_miss(pos)
  end


  def get_attack
    moves_used.merge!(last_move) unless last_move.nil?
    attack = generate_attack
  end

  
    private

    attr_reader :trails

    ## runs AI to update @trails if there was a new hit last move,
    ## then it attacks the top priority trail or generates a random move if
    ## there are none to follow
    def generate_attack
      moves_used.merge!(last_move) unless last_move.nil?
      @trails.reject! { |pos| moves_used.include? pos }
      track_last_hit if last_move && last_move.values[0] == :hit
      return generate_random if trails.empty?
      @trails[0]
    end


    ## returns a random spot that hasn't previously been fired upon
    def generate_random
      attack = [rand(0..9), rand(0..9)]
      return attack unless moves_used.keys.include?(attack)
      generate_random
    end

    ## called if last attack was a hit, selects potential neighbors
    ## and any nearby spots that were also hits to be prioritized for @trails
    def track_last_hit
      potential_strikes = generate_unmarked_neighbors
      hot_trails = generate_hit_neighbors
      prioritize_trails(hot_trails, potential_strikes) 
    end



    ## select any trails that have begun to form a line
    def prioritize_trails(hot_trails, potentials)
      hot = []
      hot_trails.each do |hit|
        if hit == left && potentials.include?(right)
          hot << right
        elsif hit == right && potentials.include?(left)
          hot << left
        end
        if hit == down && potentials.include?(up)
          hot << up
        elsif hit == up && potentials.include?(down)
          hot << down
        end
      end

      clean_trails(hot, potentials)
    end
    
    ## reject previously used or duplicated trails and 
    ## update @trails to follow hot ones first
    def clean_trails(hot, potentials)
      @trails.reject! { |pos| hot.include?(pos) }
      potentials.reject! { |pos| hot.include?(pos) || @trails.include?(pos) }
      potentials = remove_false_trails(hot, potentials) unless hot.empty?
      @trails = hot + @trails + potentials
    end

    

    ## deters excessive hit clumping after a hot trail has been found
    def remove_false_trails(hot, potentials)
      if ([left, right].any? { |pos| hot.include? pos }) && 
           ([up, down].none? { |pos| hot.include? pos })
           potentials.delete_if { |pos| [up, down].include? pos }
      end
      if ([up, down].any? { |pos| hot.include? pos }) && 
           ([left, right].none? { |pos| hot.include? pos })
           potentials.delete_if { |pos| [left, right].include? pos }
      end
      potentials
    end


    ## helpers for finding neighbors to the last move if it was a hit
    def left
      x, y = last_move.keys[0]
      [(x - 1), y]
    end

    def right
      x, y = last_move.keys[0]
      [(x + 1), y]
    end

    def up
      x, y = last_move.keys[0]
      [x, (y - 1)]
    end

    def down
      x, y = last_move.keys[0]
      [x, (y + 1)]
    end

    ## returns any potential neighbors to the last hit that are in range
    ## and haven't been fired on already
    def generate_unmarked_neighbors
      [left, right, up, down].select do |pos|
        board.in_range?(pos) && moves_used.keys.none? { |used| used == pos } 
      end
    end

    ## returns any neighbors that were hits to aid in forming lines for identifying
    ## hot trails
    def generate_hit_neighbors
      [left, right, up, down].select do |pos|
        moves_used.keys.any? { |used| used == pos && moves_used[used] == :hit } 
      end
    end

end

## for more readable printing in game
class String

  def water
    "\033[94m#{self}\033[0m"
  end

  def red
    "\033[91m#{self}\033[0m"
  end

  def clear_screen_before
    "\033[H\033[2J#{self}"
  end

end


game = Game.new(ComputerPlayer.new, ComputerPlayer.new)

game.run_setup_phase

