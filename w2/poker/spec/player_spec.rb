require 'player'
require 'rspec'

describe Player do

	let(:player) { Player.new("zack", 400) }

	it "initializes with a name and a pot" do
		expect(player.name).to eq("zack")
		expect(player.pot).to eq(400)
	end


	describe "#deduct_amt(amt) and #add_amt(amt)" do
		before do
			player.pot = 1000
		end
		
		it "deduct subtracts the correct amount" do
			player.deduct_amt(200)
			expect(player.pot).to be 800
		end

		it "add adds the correct amount" do
			player.add_amt(200)
			expect(player.pot).to be 1200
		end
	end

	describe "#get_action" do
		it "allows player to fold, see, or raise" do
			expect([:fold, :see, :raise].include?(player.get_action)).to be_truthy
		end
	end
end