def factors(num)
	factors = [[1, num]]
	i = 2
	while i <= Math.sqrt(num)
		other_factor, remainder = num.divmod(i)
		factors << [i, other_factor] if remainder == 0
		i += 1
	end
	factors
end

p factors(10) == [[1,10],[2,5]] 
p factors(16) == [[1,16],[2,8], [4,4]]
p factors(12) == [[1,12],[2,6],[3,4]] 

#really important iteration notes
# start = Time.now
# catch :stop do 
# 	up, down = true, false
# 	i = 0
# 	while up
# 		if i == 20	
# 			up, down = down, up 
# 			puts "(#{"\u02AC"*i})".center(30, '~')
# 			i -= 2
# 		end
# 		while down
# 			puts "\\#{"_"*i}/".center(30, '~')
# 			i -= 2
# 			if i == 0
# 				up, down = down, up 
# 				i += 2
# 			end
# 		end
# 		puts "/#{"_"*i}\\".center(30, '~')
# 		i += 2
# 		throw :stop if ((Time.now-start) > 3)
# 	end
# end