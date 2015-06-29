require 'byebug'
# @steps1 = 0
# @steps2 = 0

def range(start, finish)
  return [] if finish < start

  arr = [finish]
  range(start, finish - 1) + arr
end

def recursive_sum(array)
  return 0 if array.empty?

  array.first + recursive_sum(array.drop(1))
end

def iterative_sum(array)
  array.inject(:+)
end

def exp1(num, exp)
  #@steps1 += 1
  return 1 if exp == 0

  num * exp1(num, exp - 1)
end

def exp2(num, exp)
  #@steps2 += 1
  return 1 if exp == 0
  return num if exp == 1

  if exp.even?
    temp_square = exp2(num, exp / 2)
    temp_square * temp_square
  else
    temp_square = (exp2(num, (exp - 1) / 2))
    num * temp_square * temp_square
  end

end

class Array

  def deep_dup
    return self.dup if self.none? {|i| i.is_a?(Array)}
    arr = []
    self.each do |el|
      if el.is_a? Array
        arr << el.deep_dup
      else
        arr << el
      end
    end
    arr
  end


end



  def recursive_fibonacci(n)
    return [] if n      == 0
    return [0] if n     == 1
    return [0, 1] if n  == 2

    temp_arr = recursive_fibonacci(n - 1)
    current_fib = temp_arr[-2] + temp_arr[-1]
    temp_arr << current_fib
  end

  def iterative_fibonacci(n)
    return [] if n == 0
    return [0] if n == 1

    arr = [0, 1]
    while arr.length < n
      arr << arr[-1] + arr[-2]
    end

    arr
  end


  def bsearch(arr, target)
    return nil if arr.empty? || arr.length == 1 && arr[0] != target
    return 1 if arr.length == 1
    pivot = arr.length / 2

    return pivot if arr[pivot] == target

    if arr[pivot] > target
      difference = bsearch(arr[0...pivot], target)
      return nil if difference.nil?
      pivot - difference
    else
      difference = bsearch(arr[pivot..-1], target)
      return nil if difference.nil?
      pivot + difference
    end
  end



## TO DO optimize to avoid double counting
  def make_change(change, coins)
    return change if coins.include? change
    
    useable = coins.select { |coin| coin < change }
    opt_combo = nil
    useable.each_with_index do |coin, idx|
      temp_combo = [coin, make_change(change - coin, useable)].flatten
      
      if opt_combo.nil? || temp_combo.length < opt_combo.length
        opt_combo = temp_combo 
      end
    end

    opt_combo
  end


  

if __FILE__ == $PROGRAM_NAME
  p make_change(14, [10, 7, 1])        == [7, 7]
  p bsearch([1, 2, 3], 1)              == 0
  p bsearch([2, 3, 4, 5], 3)           == 1
  p bsearch([2, 4, 6, 8, 10], 6)       == 2
  p bsearch([1, 3, 4, 5, 9], 5)        == 3
  p bsearch([1, 2, 3, 4, 5, 6], 6)     == 5
  p bsearch([1, 2, 3, 4, 5, 6], 0)     == nil
  p bsearch([1, 2, 3, 4, 5, 7], 6)     == nil
end
