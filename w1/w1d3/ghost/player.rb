class Player

  attr_reader :name
  attr_accessor :losses

  def initialize(name)
    @name = name
    @losses = 0
  end

  def prompt_move
    puts "What letter would you like, #{name}?"
    gets.chomp.downcase
  end

  def prompt_input
    puts "Where would you like to add the letter? (1- Beginning, 2- End )"
    gets.to_i
  end
end