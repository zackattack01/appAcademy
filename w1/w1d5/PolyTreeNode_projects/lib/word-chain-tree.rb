require_relative '00_tree_node'
require 'set'
require 'byebug'

class WordChainer

  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp).to_set
  end

  def run(source, target)
    @words_visited = [source].to_set
    @target = target
    @tree_root = build_word_tree(source)
    find_path(target)
  end

  def build_word_tree(current_word)
    current_node = PolyTreeNode.new current_word
    word_queue = Queue.new

    word_queue.enqueue current_node
    until word_queue.empty?
      next_word = word_queue.dequeue
      adjacent_words(next_word.value).each do |word|
        next if words_visited.include? word

        child_node = PolyTreeNode.new word
        next_word.add_child child_node
        words_visited << word
        word_queue.enqueue child_node
        return current_node if word == target
      end
    end

    current_node
  end

  def adjacent_words(word)
    adj = @dictionary.select do |entry|
      entry.length == word.length && 
      adjacent_to?(entry, word)   &&
      words_visited.none? { |visited| entry == visited }
    end
    
    adj
  end

  def adjacent_to?(entry, word)
    word.split('').zip(entry.split('')).one? { |char1, char2| char1 != char2 } 
  end

  def find_path(target_word)
    end_node = @tree_root.bfs(target_word)
    raise "can't chain those" if end_node.nil?
    end_node.trace_path_back.reverse
  end

  private

    attr_reader :target, :words_visited
end


if __FILE__ == $PROGRAM_NAME
  puts "duck to ruby:"
  start = Time.now
  wc = WordChainer.new
  puts wc.run("duck", "ruby")
  puts "in #{Time.now - start} seconds"
end
