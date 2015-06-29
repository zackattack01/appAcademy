# string_reps = {}
# (0..9).each { |x| string_reps[x] = x.to_s }
# letters = [*'A'..'F']
# (10..15).each_with_index { |x, i| string_reps[x] = letters[i] }
# puts dig_hash.to_s

def num_to_s(num, base)
	string_reps = { 0=>"0", 1=>"1", 2=>"2", 3=>"3", 4=>"4", 5=>"5", 6=>"6", 
		7=>"7", 8=>"8", 9=>"9", 10=>"A", 11=>"B", 12=>"C", 13=>"D", 14=>"E", 15=>"F" } 
	string = ""
	pow = 1
	while (num / pow) != 0
		string.prepend string_reps[(num / pow) % base]
		pow *= base
	end
	string
end

p	num_to_s(5, 10) == "5"
p	num_to_s(5, 2)  == "101"
p	num_to_s(5, 16) == "5"

p	num_to_s(234, 10) == "234"
p	num_to_s(234, 2)  == "11101010"
p	num_to_s(234, 16) == "EA"

def caesar(string, shifts)
	string.split('').map{ |x| (((x.ord - 97 + shifts) % 26) + 97).chr }.join
end

puts caesar("hello", 3) == "khoor"
puts caesar("zany", 2) == "bcpa"