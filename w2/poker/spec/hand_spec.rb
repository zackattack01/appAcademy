require 'rspec'
require 'hand'
require 'deck'
require 'byebug'

describe Hand do
  let(:ace_of_spades) { Card.new(:ace, :spades) }
  let(:cards) { [ace_of_spades, Card.new(:two, :hearts)]}
  let(:deck) { Deck.full_deck }
  subject(:fresh_hand) { Hand.new(cards, deck)}

  describe "#initialize" do
    it "takes an array of cards and a deck" do
      expect(fresh_hand.cards.count).to be(2)
      expect(fresh_hand.deck).to be(deck)
    end
  end

  describe "#return_to_deck" do
    it "returns n cards to the deck" do
      expect(deck).to receive(:return_cards).with([fresh_hand.cards[0]]).and_call_original
      fresh_hand.return_to_deck([cards[0]])
      expect(fresh_hand.cards.count).to be(1)
      expect(deck.cards.count).to be(53)
    end
  end

  describe "#high_card" do
    it "returns the highest card in the hand" do
      expect(fresh_hand.high_card).to eq(ace_of_spades)
    end
  end

  # ----------------------------------------------------------------------------
  # hand helpers
  # ----------------------------------------------------------------------------

  let(:straight_flush) { Hand::from_string("8H 7H 6H 5H 4H", deck) }
  let(:straight_flush_lower) { Hand::from_string("7H 6H 5H 4H 3H", deck) }

  let(:four_of_a_kind) { Hand::from_string("8H 8S 8C 8D 4H", deck)}
  let(:four_of_a_kind_lower) { Hand::from_string("8H 8S 8C 8D 3H", deck)}

  let(:full_house) { Hand::from_string("8H 8S 8C 4D 4H", deck) }
  let(:full_house_lower) { Hand::from_string("7H 7S 7C 4D 4H", deck) }

  let(:flush) { Hand::from_string("8H 7H 6H 5H KH", deck) }
  let(:flush_lower) { Hand::from_string("8H 7H 6H 5H JH", deck) }

  let(:straight) { Hand::from_string("8H 7H 6H 5H 4C", deck) }
  let(:straight_lower) { Hand::from_string("7H 6H 5H 4H 3C", deck) }

  let(:three_of_a_kind) { Hand::from_string("7H 7H 7H 4H 3C", deck) }
  let(:three_of_a_kind_lower) { Hand::from_string("6H 6H 6H 4H 3C", deck) }

  let(:two_pair) { Hand::from_string("7H 7H 5H 5H 3C", deck) }
  let(:two_pair_lower) { Hand::from_string("6H 6H 5H 5H 3C", deck) }

  let(:one_pair) { Hand::from_string("7H 7H 5H 4H 3C", deck) }
  let(:one_pair_lower) { Hand::from_string("6H 6H 5H 4H 3C", deck) }

  let(:high) { Hand::from_string("AD TD 9S 5C 4C", deck) }
  let(:high_lower) { Hand::from_string("2D TD 9S 5C 4C", deck) }

  describe "#straight_flush?" do
    it "returns true" do
      expect(straight_flush.straight_flush?).to be(true)
    end

    it "returns false" do
      expect(high.straight_flush?).to be(false)
    end
  end

  describe "#four_of_a_kind?" do
    it "returns true" do
      expect(four_of_a_kind.four_of_a_kind?).to be(true)
    end

    it "returns false" do
      expect(high.four_of_a_kind?).to be(false)
    end
  end

  describe "#three_of_a_kind?" do
    it "returns true" do
      expect(three_of_a_kind.three_of_a_kind?).to be(true)
    end

    it "returns false" do
      expect(high.three_of_a_kind?).to be(false)
    end
  end

  describe "#one_pair?" do
    it "returns true" do
      expect(one_pair.one_pair?).to be(true)
    end

    it "returns false" do
      expect(high.one_pair?).to be(false)
    end
  end

  describe "#full_house?" do
    it "returns true" do
      expect(full_house.full_house?).to be(true)
    end

    it "returns false" do
      expect(high.full_house?).to be(false)
    end
  end

  describe "#two_pair?" do
    it "returns true" do
      expect(two_pair.two_pair?).to be(true)
    end

    it "returns false" do
      expect(high.two_pair?).to be(false)
    end
  end

  describe "#flush?" do
    it "returns true" do
      expect(flush.flush?).to be(true)
    end

    it "returns false" do
      expect(high.flush?).to be(false)
    end
  end

  describe "#straight?" do
    it "returns true" do
      expect(straight.straight?).to be(true)
    end

    it "returns false" do
      expect(high.straight?).to be(false)
    end
  end

  describe "#beats?" do
    it "returns correctly from two high card hands" do
      expect(high.beats?(high_lower)).to be(true)
      expect(high_lower.beats?(high)).to be(false)
    end

    it "returns correctly when given a straight flush and high card hand" do
      expect(straight_flush.beats?(high)).to be(true)
      expect(high.beats?(straight_flush)).to be(false)
    end

    it "returns correctly when given a straight flush and high card hand" do
      expect(straight_flush.beats?(high_lower)).to be(true)
      expect(high_lower.beats?(straight_flush)).to be(false)
    end

    describe "#break_tie" do
      it "deals with a Straight flush" do
        expect(straight_flush.beats?(straight_flush_lower)).to eq(true)
      end
      it "deals with a Four of a kind" do
        expect(four_of_a_kind.beats?(four_of_a_kind_lower)).to eq(true)
      end
      it "deals with a Full house" do
        expect(full_house.beats?(full_house_lower)).to eq(true)
      end
      it "deals with a Flush" do
        expect(flush.beats?(flush_lower)).to eq(true)
      end
      it "deals with a Straight" do
        expect(straight.beats?(straight_lower)).to eq(true)
      end
      it "deals with a Three of a kind" do
        expect(three_of_a_kind.beats?(three_of_a_kind_lower)).to eq(true)
      end
      it "deals with a Two pair" do
        expect(two_pair.beats?(two_pair_lower)).to eq(true)
      end
      it "deals with a One pair" do
        expect(one_pair.beats?(one_pair_lower)).to eq(true)
      end
      it "deals with a High card" do
        expect(high.beats?(high_lower)).to eq(true)
      end
    end
  end
end