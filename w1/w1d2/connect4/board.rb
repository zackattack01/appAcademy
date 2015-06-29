class Board
  ROW_COUNT = 6
  COL_COUNT = 7

  def initialize
    @grid = Array.new(ROW_COUNT) { Array.new(COL_COUNT) }
  end

  def display
    grid_for_display.each { |row| puts "|#{row.join('|')}|" }
  end

  def grid_for_display
    for_display = grid.map do |row|
      row.map do |spot|
        spot.nil? ? " " : spot
      end
    end

    for_display.unshift([*1..7].map(&:to_s))
  end

  def [](pos)
    r,c = pos
    grid[r][c]
  end

  def []=(pos, disc)
    r,c = pos
    grid[r][c] = disc
  end

  def drop_disc(column, disc)
    i = -1
    while i.abs <= grid.length
      pos = [i, (column - 1)]
      if self[pos].nil?
        self[pos] = disc
        break
      end
      i -= 1
    end
  end

  def col_full?(col)
    grid.transpose[col - 1].compact.length == ROW_COUNT
  end

  def winner
    return select_winner(grid) if select_winner(grid)

    transposed = grid.transpose
    return select_winner(transposed) if select_winner(transposed)

    left_diag = diagonals(grid)
    return select_winner(left_diag) if select_winner(left_diag)
    right_diag = diagonals(grid.map(&:reverse))
    return select_winner(right_diag) if select_winner(right_diag)

    nil
  end

  ## passed in different grids for rows, cols, and diagonals
  def select_winner(altered_grid)
    altered_grid.each do |row|
      winner = row.each_cons(4).to_a.select do |chunk|
        chunk.uniq.length == 1 && chunk.none? { |el| el.nil? }
      end

      return winner[0][0] unless winner.empty?
    end

    nil
  end


  def diagonals(grid)
    diags = []
    grid.each_with_index do |r, ri|
      next if ri < 3
      r.each_with_index do |c,  ci|
        next if ci < 3
        diags << [c, grid[ri-1][ci-1], grid[ri-2][ci-2], grid[ri-3][ci-3]]
      end
    end

    diags 
  end

  def filled?
    grid.flatten.none? { |space| space.nil? }
  end


  private

    attr_reader :grid
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new

  #30.times { b.drop_disc(rand(7), "@") }
  4.times { |i| b.drop_disc((i+1), "@")}
  3.times { |i| b.drop_disc((i+1), "@")}
  2.times { |i| b.drop_disc((i+1), "@")}
  1.times { |i| b.drop_disc((i+1), "@")}
  b.display
  p b.winner
end