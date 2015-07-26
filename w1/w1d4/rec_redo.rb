require 'byebug'

## WARM-UP EXERCISES ######
def rec_range(start, finish)
  return [] if finish < start

  rec_range(start, finish - 1).concat([finish])
end

def rec_sum(arr)
  return 0 if arr.empty?

  arr.first + rec_sum(arr[1..-1])
end

def iterative_sum(arr)
  sum = 0
  arr.each { |el| sum += el }
  sum
end

## EXPONENTIATION ###
def lazy_exp(base, exp)
  return 1 if exp == 0

  base * lazy_exp(base, exp - 1)
end

def smart_exp(base, exp)
  return 1 if exp == 0
  return base if exp == 1

  num = smart_exp(base, exp / 2)
  if exp.even?
    num * num
  else
    base * num * num
  end
end


### DEEP DUP ########
class Array

  def deep_dup 
    self.map do |el| 
      if el.is_a?(Array)
        el.deep_dup
      elsif el.frozen?
        el
      else
        el.dup
      end
    end
  end
end

#### FIBONACCI ######
def fibonacci(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2

  fibs = fibonacci(n  - 1)
  fibs << fibs[-2] + fibs[-1]
end

#### BINARY SEARCH ########
def bsearch(arr, target)
  return nil if arr.empty? || (arr.length == 1 && arr.first != target)
  
  pivot = arr.length / 2
  return pivot if arr[pivot] == target
  
  left, right = arr.take(pivot), arr.drop(pivot)
  if arr[pivot] > target
    bsearch(left, target)
  else
    space_after_pivot = bsearch(right, target)
    return nil if space_after_pivot.nil?
    pivot + space_after_pivot
  end
end


###### MAKE CHANGE ########
def make_change(amount, coins)
  #@call_count += 1
  return amount if coins.include? amount

  potentials = coins.select { |coin| coin < amount }
  least_change = nil
  potentials.each do |coin|
    change = [coin, make_change(amount - coin, potentials)].flatten
    
    least_change = change unless least_change                 && 
                          least_change.length < change.length
  end

  least_change
end

class Array
  
  def merge_sort
    
    print "\n\t\t\t#{self} called merge_sort"
    if length <= 1
      puts " ...but was a BASE CASE WOOOOOOOO!"
      return self 
    end

    pivot = length / 2
    puts "\n\nso merge sort splits and the LEFT side (#{take(pivot)}) recurses"
    left = self.take(pivot).merge_sort
    puts "\n\t\t\t\t\tthen the call from #{self} begins its RIGHT side (#{drop(pivot)}) recursion"
    right = self.drop(pivot).merge_sort
    puts "\n\t\t\t\t so now #{self} has split into:"
    puts "\t\t\t\t\t #{left}    and    #{right}"
    merged = merge(left, right)
    puts "\n\t\t\t...which back here in #{self}'s merge_sort is #{merged}"
    merged
  end

  def merge(left, right)
    puts "\n\t\t\t\t^^^^ merge was called on those guys ^^^^"
    merged = []
    until left.empty? || right.empty?
      merged << (left[0] < right[0] ? left.shift : right.shift)
    end
    puts "\t\t\t\t....and returned #{merged} + #{left} + #{right}"
    merged + left + right
  end

  def subsets
    return [[]] if self.empty?

    lil_subs, big_subs = self.take(length - 1).subsets, []
    lil_subs.each do |lil_sub|
      big_subs << lil_sub + [self.last]
    end

    lil_subs + big_subs
  end
end





if __FILE__ == $PROGRAM_NAME

  p rec_range(1, 9) == [*1..9]
  p rec_range(7, 3) == []

  p rec_sum([1, 2, 3, 4]) == 10
  p rec_sum([1, 2, 12, 3, 4]) == 22
  p rec_sum([1, -10, 2, 12, 3, 4]) == 12
  p rec_sum([]) == 0

  p iterative_sum([1, 2, 3, 4]) == 10
  p iterative_sum([1, 2, 12, 3, 4]) == 22
  p iterative_sum([1, -10, 2, 12, 3, 4]) == 12
  p iterative_sum([]) == 0

  p lazy_exp(2, 14) == 16384
  p lazy_exp(4, 6) == 4096
  p lazy_exp(31, 2) == 961
  p lazy_exp(9, 1) == 9
  p lazy_exp(9, 0) == 1

  p smart_exp(2, 14) == 16384
  p smart_exp(4, 6) == 4096
  p smart_exp(31, 2) == 961
  p smart_exp(9, 1) == 9
  p smart_exp(9, 0) == 1

  robot_parts = [
    ["nuts", "bolts", "washers"],
    ["capacitors", "resistors", "inductors"]
  ]

  deep_duped = robot_parts.deep_dup
  deep_duped[1] << "LED's"
  p deep_duped[1].include?("LED's") && robot_parts.none? { |arr| arr.include? "LED's" }
  p [1, [2], [3, [4]]].deep_dup == [1, [2], [3, [4]]]

  p fibonacci(0) == []
  p fibonacci(1) == [0]
  p fibonacci(2) == [0, 1]
  p fibonacci(3) == [0, 1, 1]
  p fibonacci(10) == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

  p bsearch([1, 2, 3], 1)            == 0
  p bsearch([2, 3, 4, 5], 3)         == 1
  p bsearch([2, 4, 6, 8, 10], 6)     == 2
  p bsearch([1, 3, 4, 5, 9], 5)      == 3
  p bsearch([1, 2, 3, 4, 5, 6], 6)   == 5
  p bsearch([1, 2, 3, 4, 5, 6], 0)   == nil
  p bsearch([1, 2, 3, 4, 5, 7], 6)   == nil

  p make_change(14, [10, 7, 1]) == [7, 7]
  
  # arr = [4, 5, 1, 4, 2, 8, 9]
  # puts "\n\n\t\t\t\t\t\t;)" if arr.merge_sort == [1, 2, 4, 4, 5, 8, 9]
  # puts "\n\n\t\t\t\t\t\t;)" if [-4, 1500, 72.9, 18].merge_sort == [-4, 18, 72.9, 1500]

  p [].subsets == [[]]
  p [1].subsets == [[], [1]]
  p [1, 2].subsets == [[], [1], [2], [1, 2]]
  p [1, 2, 3].subsets == [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
end