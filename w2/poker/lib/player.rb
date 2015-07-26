class Player
	
	attr_reader :name, :hand
	attr_accessor :pot

	def initialize(name, pot)
		@name, @pot, @hand = name, pot, []
	end
	
	def deduct_amt(amt)
		@pot -= amt
	end

	def add_amt(amt)
		@pot += amt
	end
	
	def prompt_for_bet
		bet = (1..50).to_a.sample
		raise "player can't cover bet" if pot < bet
		bet		
	end

	def receive_cards(cards)
		hand.concat(cards)
	end
	
	def get_action
		[:fold, :see, :raise].sample
	end

	def get_returned_cards
		hand.shuffle.pop(rand(0..3))
	end

end