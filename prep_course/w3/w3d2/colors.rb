# [0, 1, 4, 5, 7].each do |attr|
#   puts '----------------------------------------------------------------'
#   puts "ESC[#{attr};Foreground;Background"
#   30.upto(37) do |fg|
#     40.upto(47) do |bg|
#       print "\033[#{attr};#{fg};#{bg}m #{fg};#{bg}  "
#     end
#   puts "\033[0m"
#   end
# end
######## snippet from SO ^^^ ######

# puts "Testing testing one fish two fish \033[31mRED FISH\033[34m BLUE FISH\033[0m"
# (90..97).each do |i|
#     puts "\033[#{i}m are you my orange: #{i}\033[0m"
# end
#puts "\033[93m ORANGE \033[31m vs. \033[1;33m YELLOW\033[0m"#=> same
#puts "\033[38;5;202m Orange: 202 \033[38;5;208m Orange: 208 \033[0m"#=> 208
#puts "back to normal"
print "\033[4;48;5;016m"
colors = { :R => 91, :G => 92, :Y => 93, :B => 94,
	 :P => 95, :O => "38;5;208"}
colors.each_pair do |name, val|
  print "\033[#{val}m #{name.to_s}  "
end
  puts "\033[0m"


## clear terminal screen with"\e[H\e[2J”
  