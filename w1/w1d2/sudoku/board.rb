require_relative 'tile'

class Board

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(path)
    lines = File.readlines(path).map { |row| row.chomp.split('') }
    grid = lines.map do |line| 
      line.map { |spot| Tile.new(spot.to_i, spot != "0") } 
    end

    Board.new(grid)
  end

  def render
    grid.each { |row| puts row.join }
  end

  def [](pos)
    r, c = pos
    grid[r][c]
  end

  def []= (pos, input)
    r, c = pos
    grid[r][c].value = input
  end

  def valid_solution?
    return false if grid.flatten.include? 0
  
    grid.all? { |row| valid_numbers? row }           &&
    grid.transpose.all? { |col| valid_numbers? col } &&
    quadrants.all? { |quad| valid_numbers? quad }
  end

  def quadrants
    squares = grid.each_slice(Math.sqrt(grid.length)).to_a
    squares.map{ |slice| slice.transpose }.flatten.each_slice(grid.length).to_a
  end

  def valid_numbers?(arr)
    values(arr).sort == [*1..9]
  end

  def values(arr)
    arr.map { |tile| tile.value }
  end

  private

    attr_reader :grid
end


if __FILE__ == $PROGRAM_NAME
  board = Board.from_file("puzzles/sudoku1.txt")
  board.render
end