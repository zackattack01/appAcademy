require 'rspec'
require 'card'
require 'deck'

describe Deck do

  subject(:partial_deck) do
     Deck.new([Card.new(:ace, :spades), Card.new(:two, :hearts)])
   end

  describe "#initialize" do
    it "allows a partial deck" do
      expect(partial_deck.count).to be(2)
    end
  end

  subject(:fresh_deck) { Deck.full_deck }
  describe "::full_deck" do
    it "returns a full deck of cards" do
      expect(fresh_deck.count).to eq(52)
    end
  end

  describe "#shuffle" do
    it "calls the array#shuffle method" do
      # cards = fresh_deck.send(:cards)
      # cards = fresh_deck.instance_variable_get(:@cards)

      expect(fresh_deck.cards).to receive(:shuffle)

      fresh_deck.shuffle
    end
  end

  describe "#take" do
    it "takes n number of cards from the deck" do
      partial_deck.take(2)
      expect(partial_deck.count).to be(0)
    end

    subject(:returned_cards) { partial_deck.take(1) }
    it "takes the correct cards from top of the deck" do
      expect(returned_cards[0].value).to eq(:ace)
    end
  end

  describe "#return_cards" do
    it "puts cards back in the bottom of the deck" do
      cards = partial_deck.take(2)
      partial_deck.return_cards(cards)
      expect(partial_deck.count).to eq(2)
    end

    it "puts cards back in the bottom of the deck" do
      cards = partial_deck.take(2)
      partial_deck.return_cards(cards)
      partial_deck.return_cards(cards)
      expect(partial_deck.count).to eq(4)
    end
  end
end
