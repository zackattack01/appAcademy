require 'card'

class Deck
  
  attr_reader :cards  

  def self.full_deck
    all_cards = Card::values.product(Card::suits)
    cards = all_cards.map { |(value, suit)| Card.new(value, suit) }

    Deck.new(cards)
  end

  def initialize(cards)
    @cards = cards
  end

  def count
    @cards.length
  end

  def shuffle
    @cards = cards.shuffle
  end

  def take(n)
    @cards.shift(n)
  end

  def return_cards(cards)
    @cards.concat(cards)
  end    
end