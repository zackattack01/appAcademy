require_relative 'player'
require_relative 'deck'

class Game
	
	RAISE_AMOUNT = 5
	ANTE = 1

	attr_reader :players, :deck, :pot
	attr_accessor :current_bet

	def initialize(players)
		@players = players
		@deck = Deck.full_deck
		@pot = 0
	end

	def run
		setup_game
		run_round(players) until players.count == 1
	end

	def setup_game
		5.times do 
			players.each do |player|
				deal_cards(player, 1)
			end
		end
	end

	def prune_players
		players.delete_if { |player| player.pot <= 0 }
	end

	def run_round(current_players, phase = 1)
		@current_bet = nil
		next_round_players = []
		current_players.each { |player| player.deduct_amt(ANTE) }

		current_players.each do |player|
			if current_bet.nil?
				bet = player.prompt_for_bet
				unless bet == :fold
					next_round_players << player 
					@current_bet = bet
				end
				next
			end
			action = player.get_action
			unless action == :fold
				next_round_players << player 
				self.send(action)
			end
		end	
		
		if next_round_players.count > 1 && phase == 1
			run_draw_phase(next_round_players) 
			run_round(next_round_players, 2)
		elsif phase == 2 && next_round_players.count > 1
			pay_winner(compare_hands(next_round_players))
		else
			pay_winner(next_round_players.first)
		end			
	end

	def compare_hands(remaining_players)
		remaining_players.each do |player|
			remaining_players.each do |opp|
				next unless player != opp && player.hand.beats?(opp.hand)
				return player
			end
		end
	end

	def add_to_pot(amt)
		@pot += amt
	end

	def pay_winner(winner)
		winner.add_amt(pot)
		@pot = 0
	end

	def run_draw_phase(current_players)
		current_players.each do |player|
			deck.return_cards(player.get_returned_cards)
			deal_card(player) until player.hand.count == 5
		end
	end

	def deal_card(player)
		player.receive_cards(deck.take(1))
	end

	private

		attr_writer :pot

		def see(player)
			player.deduct_amt(current_bet)
			add_to_pot(current_bet)
		end

		def raise(player)
			@current_bet += RAISE_AMOUNT
			player.deduct_amt(RAISE_AMOUNT + current_bet)
			add_to_pot(current_bet)
		end

end