class PolyTreeNode
  attr_reader :value, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  # have a public children reader which returns a copy
  # have a protected children reader which returns the real thing
  def children
    @children.dup
  end

  def parent=(new_parent)
    parent._children.delete(self) unless parent.nil?
    @parent = new_parent
    parent._children << self unless parent.nil?
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise "Node has no parent" if node.parent.nil?
    node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = Queue.new
    queue.enqueue(self)

    until queue.empty?
      el = queue.dequeue
      return el if el.value == target_value
      el.children.each do |child|
        queue.enqueue(child)
      end
    end
    nil
  end

  def trace_path_back
    path_nodes = []
    current_node = self
    until current_node.parent.nil?
      path_nodes << current_node.value
      current_node = current_node.parent
    end

    path_nodes << current_node.value
  end

  protected

  def _children
    @children
  end

end


class Queue

  def initialize
    @store = []
  end

  def enqueue(value)
    @store << value
  end

  def dequeue
    @store.shift
  end

  def peek
    @store[0]
  end

  def empty?
    @store.empty?
  end
end
