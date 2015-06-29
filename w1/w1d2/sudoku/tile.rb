require 'colorize'

class Tile
  attr_reader :given
  attr_accessor :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    if given
      value.to_s.colorize(:blue)
    elsif value == 0
      value.to_s.colorize(:yellow)
    else
      value.to_s.colorize(:red)
    end
  end
end


=begin ## cool color stuff but just use colorize
class Fixnum
  def blue
    "\033[94m#{self.to_s}\033[0m"
  end

  def yellow
    "\033[93m#{self.to_s}\033[0m"
  end

  def red
    "\033[91m#{self.to_s}\033[0m"
  end
end
=end