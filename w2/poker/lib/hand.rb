require_relative 'card'
require 'byebug'

class Hand

  RANKED_HANDS = [
                    :straight_flush?,
                    :four_of_a_kind?,
                    :full_house?,
                    :flush?,
                    :straight?,
                    :three_of_a_kind?,
                    :two_pair?,
                    :one_pair?,
                    :just_add_them?
                  ]

  def self.from_string(str, deck)
    Hand.new(Card::from_string(str), deck)
  end

  attr_reader :cards, :deck

  def initialize(cards, deck)
    @cards = cards
    @deck = deck
  end

  ## TODO refactor
  def return_to_deck(returned_cards)
    to_return = cards.select do |card|
      returned_cards.any? { |returned| returned.object_id == card.object_id }
    end
    deck.return_cards(to_return)
    cards.reject! do |card|
      returned_cards.any? { |returned| returned.object_id == card.object_id }
    end
  end

  def high_card
    cards.max
  end

  def count
    cards.count
  end

  def beats?(other_hand)
   hands = { self => nil, other_hand => nil}
    [self, other_hand].each do |hand|
      RANKED_HANDS.each_with_index do |hand_to_check, idx|
        if hand.send(hand_to_check)
          hands[hand] = idx
          break
        end
      end
    end

    if hands[self] < hands[other_hand]
      true
    elsif hands[self] == hands[other_hand]
      break_tie(hands[self], other_hand)
    else
      false
    end
  end

  def break_tie(which_tie, other_hand)
    my_vals, opp_vals = values, other_hand.values

    case
    when [0, 3, 4].include?(which_tie)  #straight flush or flush or straight
       self.high_card > other_hand.high_card
    when which_tie == 1 #four of a kind
      my_outside_card = cards.find{ |card| cards.count(card) == 1 }
      other_outside_card = other_hand.cards.find do |card| 
        other_hand.cards.count(card) == 1 
      end
      my_outside_card > other_outside_card
    when [2, 5].include?(which_tie)#2 || 5 #full house or three of a kind
      my_triple = my_vals.find{ |val| my_vals.count(val) == 3 }
      other_triple = opp_vals.find{ |val| opp_vals.count(val) == 3 }
      my_triple > other_triple
    when [6, 7].include?(which_tie)#6 || 7 # two pair or one pair
      my_high_double = cards.select { |card| cards.count(card) == 2 }.max
      other_high_double = other_hand.cards.select do |card| 
        other_hand.cards.count(card) == 2 
      end.max
      my_high_double > other_high_double
    when which_tie == 8 ## just add them
      my_points = cards.map(&:poker_value).inject(:+)
      opponent_points = other_hand.cards.map(&:poker_value).inject(:+)
      my_points > opponent_points
    else
      raise "check what's being passed into break tie"
    end
  end

  def straight?
    values.max - values.min == 4
  end
  
  def flush?
    suits.uniq.count == 1
  end

  def one_pair?
    values.uniq.length == 4
  end

  def straight_flush?
    suits.uniq.count == 1 &&
    values.max - values.min == 4
  end

  def four_of_a_kind?
    values.any? { |val| values.count(val) == 4 }
  end

  def three_of_a_kind?
    values.any? { |value| values.count(value) == 3 }
  end

  def full_house?
    values.uniq.count == 2
  end

  def two_pair?
    values.count { |value| values.count(value) == 2 } == 4
  end

  def just_add_them?
    true
  end

  def suits
    cards.map(&:suit)
  end

  def values
    cards.map(&:poker_value)
  end
end