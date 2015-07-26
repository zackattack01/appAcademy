######  ENUMERABLE ###### 
  # Write a method that takes a range of the integers from 1 to 100
  # and uses select to return an array of those that are perfect
  # squares.
  nums = (1..100)
  nums.select { |i| Math.sqrt(i) == Math.sqrt(i).round }  
  #=> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

  # Using any?, verify that the range of integers from 1 to 5 does
  # include at least one odd number
  nums = (1..5)

  nums.any? { |i| i % 2 == 1 }
  # => true

  # Write a method that takes an array of integers and returns an array 
  # with the array elements multiplied by two.
  def times_two(integers)
    integers.map{ |x| x*2 }
  end

  times_two([0, 1, 2, 3, 4])
  #=> [0, 2, 4, 6, 8]

  # Extend the Array class to include a method named my_each 
  # that takes a block, calls the block on every element of 
  # the array, and then returns the original array. Do not use
  # Ruby's Enumerable's each method. I want to be able to write:
  class Array
    def my_each
      i = 0
      while i < self.count
        yield(self[i])
        i += 1
      end
      self
    end
  end

  # return_value = [1, 2, 3].my_each do |num|
 #    puts num
  # end.my_each do |num|
 #    puts num
  # end

 ##prints 1 2 3 1 2 3
 #return_value # => [1, 2, 3]

 # Write a method that finds the median of a given array of integers. 
 # If the array has an odd number of integers, return the middle item from 
 # the sorted array. If the array has an even number of integers, return 
 # the average of the middle two items from the sorted array. 
 # (You actually don't need to use any enumerable methods for this).
 def median_finder(integers)
  if integers.count % 2 == 1
    integers.sort[(integers.count/2)]
  else
    [integers.sort[integers.count/2], 
    integers.sort[(integers.count/2)-1]].inject(:+).fdiv(2)
  end
 end

 median_finder([1, 2, 3, 4, 5, 4, 5, 2, 1]) #=> 3
 median_finder([1, 2, 3, 4, 5, 1, 2, 3, 4, 5]) #=> 3.0

 ## Create a method that takes in an Array of Strings and uses inject to 
 ## return the concatenation of the strings

 def concatenate(strings)
  return strings.inject(:+)
 end

 p concatenate(["Yay ", "for ", "strings!"]) == "Yay for strings!"
 