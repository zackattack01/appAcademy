# Implement a Rock, Paper, Scissors game. The method rps should take a string 
# (either "Rock", "Paper" or "Scissors") as a parameter and return the 
# computer's choice, and the outcome of the match
class RpsGame

  def run_game 
   again = true
    while again
    	again = false
    	print "\nRock     "
    	sleep 0.4
    	print "Paper     "
    	sleep 0.4
    	puts "Scissors"
    	sleep 0.4
    	puts "\n         SHOOT!"
    	rps(gets.chomp)
    	puts "Again?(y/n)"
    	again = gets.chomp == "y" ? true : false
    end 
  end
  
  def rps(opponent_choice)
  	choices = %w{ Rock Paper Scissors }
  	outcome = nil
  	my_choice = choices.sample
  	if !choices.include?(opponent_choice)
  		puts "Please choose a valid option"
  		rps(gets.chomp)
  	elsif my_choice == opponent_choice
  		outcome = "draw"
  	elsif (my_choice == "Rock" && opponent_choice == "Scissors") || 
  		(my_choice == "Scissors" && opponent_choice == "Paper") ||
  		(my_choice == "Paper" && opponent_choice == "Rock")
  		outcome = "you lose"
  	else
  		outcome = "you win"
  	end
  	  puts "#{my_choice}, #{outcome}"
  end
end
# game= RpsGame.new
# game.run_game

# Implement a Mixology game. The method remix should take an array of ingredient 
# arrays (one alcohol, one mixer) and return the same type of data structure, 
# with the ingredient pairs randomly mixed up. Assume that the first item in the 
# pair array is alcohol, and the second is a mixer. Don't pair an alcohol with an
# alcohol with or a mixer with a mixer. 
def remix(ingredients)
	sorted = ingredients.flatten.group_by.with_index{ |ing, idx| idx.even? }.values
	sorted = sorted.map{ |group| group.shuffle }
	sorted[0].zip(sorted[1])
end

##bonus guarantees new mixer
def remix_guaranteed(ingredients)
	sorted = ingredients.flatten.group_by.with_index{ |ing, idx| idx.even? }.values
	sorted[0] = sorted[0].rotate
	sorted[0].zip(sorted[1])
end

# p remix([
#   ["rum", "coke"],
#   ["gin", "tonic"],
#   ["scotch", "soda"]
# ])

# p remix_guaranteed([
#   ["rum", "coke"],
#   ["gin", "tonic"],
#   ["scotch", "soda"]
# ])