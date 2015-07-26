require 'rspec'
require 'game'
require 'player'

describe Game do 

	let(:player1) { double("player1") }
	let(:player2) { double("player2") }
	let(:player3) { double("player3") }
	let(:player4) { double("player4") }
	let(:players) { [player1, player2, player3, player4] }
	let(:game) { Game.new(players) }

	describe "#initialize" do 
		it "initializes with an array of players" do
			expect(game.players.count).to be 4
		end

		it "sets the pot to 0" do 
			expect(game.pot).to be 0
		end

		it "and starts with a full deck" do
			expect(game.deck.count).to be 52
		end
	end

	describe "#deal_card(player)" do 
		it "deals n cards to the intended player" do
			allow(player1).to receive(:receive_cards).with([game.deck.cards[0]])
			game.deal_card(player1)
			expect(game.deck.count).to be 51
		end
	end

	describe "#prune_players" do 
		it "removes only players with an empty pot" do
			players[0..-2].each do |player|
				allow(player).to receive(:pot).and_return(0)
			end

			allow(players.last).to receive(:pot).and_return(2)
			game.prune_players
			expect(game.players.count).to be 1
		end
	end

	let(:player_a) { Player.new("zack", 200) }
	let(:player_b) { Player.new("other_guy1", 200) }
	let(:player_c) { Player.new("other_guy2", 200) }
	let(:player_d) { Player.new("other_guy3", 200) }
	let(:real_players) { [player_a, player_b, player_c, player_d] }
	let(:real_game) { Game.new(real_players) }

	describe "#pay_winner" do 
		it "pays current pot to the winner" do
			real_game.add_to_pot(200)
			expect(player_a).to receive(:add_amt).with(200)
			
			real_game.pay_winner(player_a)
		end
	end

	describe "#run_draw_phase" do 
		it "allows players to put cards back and deals them the correct amount" do
			5.times { real_game.deal_card(player_a) }
			4.times { real_game.deal_card(player_b) }

			real_game.run_draw_phase([player_a, player_b])
			expect(player_a.hand.count).to be 5
			expect(player_b.hand.count).to be 5
		end
	end	


## TODO integration tests for run_round and compare_hands
end