######### ARRAYS ########
class Array
  
## Write your own uniq method, called my_uniq; 
##it should take in an Array and return a new array.
  def my_uniq
    uniq_elements = []
    self.each do |element|
    	uniq_elements << (uniq_elements.include?(element) ?  nil : element)
    end
    uniq_elements.compact
  end

## Take the my_uniq method that you just wrote and modify it slightly so 
## that it can be called directly on an array:
  def my_uniq!
	self.map!.with_index do |element, idx|
    	self[0...idx].include?(element) ? nil : element
    end.compact!
  end

## Write a new Array#two_sum method that finds all pairs of positions 
## where the elements at those positions sum to zero.
## NB: ordering matters. I want each of the pairs to be 
## sorted smaller index before bigger index. 
## I want the array of pairs to be sorted "dictionary-wise":
  def two_sum
  	pairs = []
  	return [] if self.length < 2
  	self.each_with_index do |base, base_idx|
  		self[base_idx+1..-1].each_with_index do |test, test_idx|
  			pairs << [base_idx, (base_idx + test_idx + 1)] if (test + base == 0)
  		end
  	end
  	pairs
  end


end

######  MY_UNIQ ###### 
# understandably_repetitive_daily_rankings_of_my_array_naming_perspicuity = [10, 10, 10, 10, 10, 9, 10, 10, 10, 10, 10, 10, 10, 9]

# after_safe_uniq_call = understandably_repetitive_daily_rankings_of_my_array_naming_perspicuity.my_uniq
# #puts "Original array after safe my_uniq call: #{understandably_repetitive_daily_rankings_of_my_array_naming_perspicuity}"
# ##=> Original array after safe my_uniq call: [10, 10, 10, 10, 10, 9, 10, 10, 10, 10, 10, 10, 10, 9]


# #puts "Returned array: #{after_safe_uniq_call}"
# ##=> Returned array: [10, 9]

# understandably_repetitive_daily_rankings_of_my_array_naming_perspicuity.my_uniq!
# #puts "Original array after unsafe my_uniq call: #{understandably_repetitive_daily_rankings_of_my_array_naming_perspicuity}"
# ##=> Original array after unsafe my_uniq call: [10, 9]

###### TWO_SUM ###### 

#print [-1, 0, 2, -2, 1].two_sum
##=> [[0, 4], [2, 3]]

### MY_TRANSPOSE ###
# Write a method, my_transpose, which will convert between the row-oriented and 
# column-oriented representations. You may assume square matrices for simplicity's sake.
  def my_transpose(matrix)
 		transposed = [[]]*matrix.count
  	matrix.flatten.each_with_index do |x, idx| 
  		transposed[(idx % (matrix.count))] += [x]
  	end
  	transposed
  end


  matrix = [[0, 1, 2],[3, 4, 5],[6, 7, 8]]
	
#p my_transpose(matrix)  #=> [[0, 3, 6], [1, 4, 7], [2, 5, 8]]


## STOCK PICKER ###
# Write a method that takes an array of stock prices (prices on days 0, 1, ...), 
## and outputs the most profitable pair of days on which to first buy the stock and then sell the stock.

	def stock_picker(days)
	  
	  if days.index(days.max) > days.index(days.min)
      return [days.index(days.min), days.index(days.max)] 
    end    

	  current_max = {}
	  days[0..-2].each_with_index do |day, idx|
	  	if current_max.empty? || 
        ((days[(idx + 1)..-1].max - day) > current_max.keys[0]) 
	  		current_max = { (days[(idx + 1)..-1].max - day) => 
          [idx, (days[(idx + 1)..-1].index(days[(idx + 1)..-1].max) + idx + 1)] } 
	  	end
	  end
	  current_max.values.first

	end

	 days = []
	 365.times { days << (0..500).to_a.sample }
	 p stock_picker(days)