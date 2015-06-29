class Array
	def sum
		empty? ? 0 : inject(:+)
	end

	def square
		empty? ? [] : map { |el| el ** 2 }
	end

	def square!
		empty? ? clear : map! { |el| el ** 2 }
	end

end