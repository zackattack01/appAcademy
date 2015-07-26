require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:ace, :spades) }

  describe "#initialize" do
      it "initializes with a suit and value" do
        expect(card.suit).to eq(:spades)
        expect(card.value).to eq(:ace)
      end
  end

  describe "#override spaceship operator" do
    subject(:two_of_hearts) { Card.new(:two, :hearts) }
    subject(:king_of_diamonds) { Card.new(:king, :diamonds) }
    it "two of hearts is less than king of diamonds" do
      expect(two_of_hearts < king_of_diamonds).to be(true)
    end
  end

  describe "::suits" do
    it "returns a list of the suits" do
      expect(Card::suits).to contain_exactly(:clubs, :diamonds, :hearts, :spades)
    end
  end

  describe "::values" do
    it "returns a list of the values" do
      expect(Card::values).to include(:ace, :king, :queen, :jack, :five)
    end
  end

  describe "#suit" do
    it "returns the card's suit" do
      expect(card.suit).to eq(:spades)
    end
  end

  describe "#value" do
    it "returns the card's value" do
      expect(card.value).to eq(:ace)
    end
  end
end