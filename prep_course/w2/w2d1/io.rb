# Write a number guessing game. The computer should choose a number between
# 1 and 100. It should prompt the user for guesses. Each time, it will prompt the
# user for a guess; it will return too high or too low. It should track the number
# of guesses the player took.
def guessing_game
  again = true
  while again
  	guesses = 0
  	number = (1..100).to_a.sample
  	guessed = false
  	puts "I'm thinking of a number between 1 and 100 (inclusive)"
  	until guessed
  		sleep 0.4
  		puts "What's your guess?"
  		guess = gets.chomp.to_i
  		guesses += 1
  		puts "Correct! in #{guesses} guesses" or guessed = true if guess == number
  		puts "Higher than that" if guess < number
  		puts "Lower than that" if guess > number
  	end
  	puts "Get a calculator" if guesses > 7
  	sleep 0.4
  	puts "Again?(y/n)"
  	again = gets.chomp.downcase == "y" ? true : false 
  end
end

# guessing_game

# Write a program that prompts the user for a file name, reads that file, 
# shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". 
# You could create a random number using the Random class, or you could use the 
# shuffle method in array.

def file_shuffler
  puts "Which file would you like remixed?"
  input_name = gets.chomp
  if File.exists? input_name
  	formatted_name = input_name[0...(input_name.index("."))]
  	File.open("#{formatted_name}-shuffled.txt", "w") do |f|
    	File.readlines(input_name).shuffle.each { |line| f.puts line }
  	end
  	puts "Enjoy :)"
  else
  	puts "We're gonna need a valid file name"
  end
end

file_shuffler