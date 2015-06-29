
class Player

  attr_accessor :mark

  def initialize
    @mark = nil
  end
end

class HumanPlayer < Player

  def get_move
    col = gets.chomp.to_i
    until (1..7).to_a.include? col
      puts "Please enter a valid column between 1 and 7"
      col = gets.chomp.to_i
    end

    col
  end
end

class ComputerPlayer < Player

  def get_move
    [*1..7].sample
  end
end