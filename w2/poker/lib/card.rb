class Card

  SUIT_STRINGS = {
      :clubs    => "C",
      :diamonds => "D",
      :hearts   => "H",
      :spades   => "S"
    }

    VALUE_STRINGS = {
      :two => "2",
      :three => "3",
      :four  => "4",
      :five  => "5",
      :six   => "6",
      :seven => "7",
      :eight => "8",
      :nine  => "9",
      :ten   => "T",
      :jack  => "J",
      :queen => "Q",
      :king  => "K",
      :ace   => "A"
    }

    POKER_VALUE = {
      :two => 2,
      :three => 3,
      :four  => 4,
      :five  => 5,
      :six   => 6,
      :seven => 7,
      :eight => 8,
      :nine  => 9,
      :ten   => 10,
      :jack  => 11,
      :queen => 12,
      :king  => 13,
      :ace => 14
    }

  attr_reader :value, :suit

  def self.suits
      SUIT_STRINGS.keys
  end

  def self.values
      VALUE_STRINGS.keys
  end

  def self.from_string(str)
    string_to_suit = SUIT_STRINGS.invert
    string_to_value = VALUE_STRINGS.invert
    cards = str.split
    card_objects = []
    cards.each do |card|
      val, suit = card.split('')
      card_objects << Card.new(string_to_value[val], string_to_suit[suit])
    end

    card_objects
  end

  def initialize(value, suit)
    @suit = suit
    @value = value
  end

  include Comparable

  def <=>(other_card)
    case
    when POKER_VALUE[self.value] < POKER_VALUE[other_card.value] then -1
    when POKER_VALUE[self.value] == POKER_VALUE[other_card.value] then 0
    when POKER_VALUE[self.value] > POKER_VALUE[other_card.value] then 1
    end
  end

  def poker_value
    POKER_VALUE[value]
  end

end