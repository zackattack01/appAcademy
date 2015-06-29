class Maze
  START_MARK = "S"
  END_MARK = "E"
  attr_accessor :grid
  attr_reader :start, :finish, :name

  def initialize(grid, name)
    @grid = grid
    @name = name
    find_start_and_finish
    prep_for_exploration
    map_terrain
    mark_optimal_path_with(finish)
    write_map
  end

  ## walls set to -1, everything else to 0 for easy comparison
  def prep_for_exploration
    self.grid.map! { |row| row.map! { |spot| spot == "*" ? -1 : 0 } }
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, mark)
    grid[row][col] = mark
  end

  ## iterates through each position and sets start and finish 
  ## positions when they are found
  def find_start_and_finish
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |spot, col_idx|
        if spot == START_MARK
          @start = [row_idx, col_idx]
        elsif spot == END_MARK
          @finish = [row_idx, col_idx]
        end
      end
    end
  end


  ## starting with the finish, chooses the next closest step to the 
  ## beginning (should be 1 integer less), and calls itself again until
  ## the beginning is reached
  def mark_optimal_path_with(pos)
    if self[*pos] == 1
       self[*pos] = "X"
       return nil 
    end
    
    next_step = neighbors(*pos).select do |step| 
      self[*step] != "X" && self[*step] == (self[*pos] - 1) 
    end[0]

    self[*pos] = "X"
    mark_optimal_path_with next_step 
  
  end

 
  def map_terrain
    ## starting with positions neighboring the start
    neighbors(*start).each { |pos| self[*pos] = 1 }
    step = 1
    ## and going until we've reached the finish
    while self[*finish] == 0
      ## go through each spot in the maze
      grid.each_with_index do |row, row_i|
        row.each_with_index do |spot, col_i|
          ## if the spot you are on matches the number of steps taken
          ## mark all surrounding untouched spaces with the next step
          if spot == step
            neighbors(row_i, col_i).select { |space| empty? space }.each do |pos| 
              self[*pos] = step + 1 
            end 
          end
        end
      end
      ## and take the next step
      step += 1
    end
  end


  ## returns all neighboring spots that aren't walls
  def neighbors(x, y)
    neighbors = []
    neighbors << [(x + 1), y] if (x + 1) < grid.count
    neighbors << [(x - 1), y] if x > 0
    neighbors << [x, (y + 1)] if (y + 1) < grid[0].count
    neighbors << [x, (y - 1)] if y > 0
    neighbors.select { |pos| self[*pos] != -1 }
  end

  def empty?(pos)
    self[*pos] == 0 
  end

  ## prints solution to a file #{maze-name}_solution.txt
  def write_map
    self[*start] = START_MARK
    self[*finish] = END_MARK
    to_print = grid.map do |row|
                  row.map do |spot|
                    if spot == -1 then "*"
                    elsif "XSE".include?(spot.to_s) then spot 
                    else " " 
                    end
                  end
                end
    File.open("#{name}_solution.txt", "w") do |f|
      to_print.each { |row| f.puts row.join }
    end
  end


end



["CodeEval", "maze1"].each do |maze|
  grid = []
  File.readlines("#{maze}.txt").each do |line|
    grid << line.chomp.split('')
  end

  Maze.new(grid, "#{maze}")
end



