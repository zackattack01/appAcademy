class MyHashSet
	attr_accessor :store

	def initialize
	  self.store = {}
	end

	def insert(el)
	  store[el] = true
	end

	def include?(el)
	  store[el].nil? ? false : true
	end

	def delete(el)
	  store.delete(el) and return true if store[el]
	  false
	end

	def union(set2)
	  store.merge(set2.store.select { |key, val| !self.include? key })
	end

	def to_a
	  store.keys
	end

	def intersect(set2)
	   store.select { |key, val| set2.include? key }
	end

	def minus(set2)
	  store.select { |key, val| !set2.include? key }
	end
end

test_set1 = MyHashSet.new
test_set2 = MyHashSet.new
%w{ a b c d }.each { |x| test_set1.insert x and test_set2.insert x }
test_set1.insert "e"
test_set2.insert "f"
puts "Union: #{test_set1.union(test_set2).keys}"
puts "Intersection: #{test_set1.intersect(test_set2).keys}"
puts "Minus: #{test_set1.minus(test_set2).keys}"
p test_set1.include?("b") == true
p test_set1.include?("f") == false
p test_set1.delete("f") == false
p test_set1.delete("e") == true
p test_set1.to_a == %w{ a b c d }