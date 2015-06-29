require_relative '00_tree_node'

class KnightPathFinder
  
  attr_reader :visited_positions, :move_tree_root

  def self.valid_moves(pos)
    ops = [["+", "+"], ["+", "-"], ["-", "-"], ["-", "+"]]
    op_combos = ops.zip([[1, 2]] * 4).concat(ops.zip([[2, 1]] * 4))

    moves = op_combos.map do |ops, nums|
      pos.map.with_index { |pos_num, i| pos_num.send(ops[i], nums[i]) }
    end
  
    moves.select { |move_pos| move_pos.all? { |x| x.between?(0, 7) } }
  end

  def initialize(starting_position)
    @visited_positions = [starting_position]
    @move_tree_root = build_move_tree(starting_position)
  end

  def build_move_tree(move_pos)
    move_node = PolyTreeNode.new(move_pos)
    move_queue = Queue.new
    move_queue.enqueue(move_node)

    until move_queue.empty?
      next_move = move_queue.dequeue
      new_move_positions(next_move.value).each do |pos|
        next_move.add_child(PolyTreeNode.new(pos))
      end
      next_move.children.each { |child| move_queue.enqueue child }
    end

    move_node
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos).reject do |move|
      visited_positions.include? move
    end
    visited_positions.concat(new_moves)

    new_moves
  end

  def find_path(end_pos)
    end_node = move_tree_root.bfs(end_pos)
    raise "invalid target" if end_node.nil?
    end_node.trace_path_back.reverse 
  end

end