require_relative 'card'
require_relative 'deck'

class Hand
  attr_reader :cards

  HANDS = [:highcard, :one_pair, :two_pair, :three_kind, :full_house,
    :four_kind, :straight, :flush, :straight_flush, :royal_flush]

  def initialize(cards = [])
    @cards = cards
  end

  def empty?
    @cards.empty?
  end

  def include?(card)
    @cards.include?(card)
  end

  def add_card(card)
    raise 'Too many cards!' if num_cards >= 5
    raise 'Card already in hand' if include?(card)
    @cards << card
  end

  def remove_card(card)
    raise 'Hand is empty' if empty?
    raise 'Card not in hand' unless include?(card)
    @cards.delete(card)
  end

  def num_cards
    @cards.length
  end

  def beats?(hand)
    comp = HANDS.index(best_hand) <=> HANDS.index(hand.best_hand)
    return true if comp == 1
    return false if comp == -1
    # compare high card
    return winning_royal_flush?(hand) if best_hand == :royal_flush

    return winning_straight_flush?(hand) if best_hand == :straight_flush
    return winning_flush?(hand) if best_hand == :flush
    return winning_straight?(hand) if best_hand == :straight
    return winning_4kind?(hand) if best_hand == :four_kind
    return winning_full_house?(hand) if best_hand == :full_house
    return winning_3kind?(hand) if best_hand == :three_kind
    return winning_2pair?(hand) if best_hand == :two_pair
    return winning_1pair?(hand) if best_hand == :one_pair
    return winning_highcard?(hand) if best_hand == :highcard
  end

  def best_hand
    return :royal_flush if is_royal_flush?
    return :straight_flush if is_straight_flush?
    return :flush if is_flush?
    return :straight if is_straight?
    return :four_kind if is_4kind?
    return :full_house if is_fullhouse?
    return :three_kind if is_3kind?
    return :two_pair if is_2pair?
    return :one_pair if is_pair?
    :highcard
  end



  def winning_royal_flush?(hand)
    winning_suit(cards.sort.last, hand.cards.sort.last) == 1
  end

  def winning_straight_flush?(hand)
    winning_straight?(hand)
  end

  def winning_flush?(hand)
    winning_highcard?(hand)
  end

  def winning_straight?(hand)
    own_values = switch_ace
    opp_values = hand.switch_ace

    comp = own_values.last <=> opp_values.last
    return true if comp == 1
    return false if comp == -1

    return true if winning_suit(cards.sort.last, hand.cards.sort.last) == 1
    false
  end

  def switch_ace
    min = card_values.min
    if min == 2
      card_values.map{|val| val == 44 ? 1 : val}.sort!
    else
      card_values.sort!
    end
  end

  def winning_4kind?(hand)
    own_pair_type = Card::TYPE_VALUE[type_hash.find{|type, num| num == 4}.first]
    opp_pair_type = Card::TYPE_VALUE[hand.type_hash.find{|type, num| num == 4}.first]

    comp = own_pair_type <=> opp_pair_type
    return false if comp == -1
    true
  end

  def winning_full_house?(hand)
    own_pair_type = Card::TYPE_VALUE[type_hash.find{|type, num| num == 3}.first]
    opp_pair_type = Card::TYPE_VALUE[hand.type_hash.find{|type, num| num == 3}.first]
    comp3 = own_pair_type <=> opp_pair_type
    return false if comp3 == -1
    return true if comp3 == 1
    own_pair_type = Card::TYPE_VALUE[type_hash.find{|type, num| num == 2}.first]
    opp_pair_type = Card::TYPE_VALUE[hand.type_hash.find{|type, num| num == 2}.first]
    comp2 = own_pair_type <=> opp_pair_type
    return false if comp2 == -1
    return true if comp2 == 1
    winning_highcard?(hand)
  end

  def winning_3kind?(hand)
    own_pair_type = Card::TYPE_VALUE[type_hash.find{|type, num| num == 3}.first]
    opp_pair_type = Card::TYPE_VALUE[hand.type_hash.find{|type, num| num == 3}.first]

    comp = own_pair_type <=> opp_pair_type
    return false if comp == -1
    true
  end

  def winning_2pair?(hand)
    own_pairs = type_hash.select{|type, num| num == 2}
    opp_pairs = hand.type_hash.select{|type, num| num == 2}

    own_sorted = own_pairs.sort_by {|type, _| Card::TYPE_VALUE[type]}
    opp_sorted = opp_pairs.sort_by {|type, _| Card::TYPE_VALUE[type]}

    comp = Card::TYPE_VALUE[own_sorted.last] <=> Card::TYPE_VALUE[opp_sorted.last]
    return false if comp == -1
    return true if comp == 1

    comp2 = Card::TYPE_VALUE[own_sorted.first] <=> Card::TYPE_VALUE[opp_sorted.first]
    return false if comp2 == -1
    return true if comp == 1

    winning_highcard?(hand)
  end

  def winning_1pair?(hand)
    own_pair_type = Card::TYPE_VALUE[type_hash.find{|type, num| num == 2}.first]
    opp_pair_type = Card::TYPE_VALUE[hand.type_hash.find{|type, num| num == 2}.first]

    comp = own_pair_type <=> opp_pair_type
    return false if comp == -1
    return true if comp == 1
    winning_highcard(hand)
  end

  def winning_highcard?(hand)
    cards.sort!.reverse!
    hand.cards.sort!.reverse!
    0.upto(4) do |i|
      comp = cards[i].value <=> hand.cards[i].value
      return true if comp == 1
      return false if comp == -1
    end

    comp = winning_suit(cards.first, hand.cards.first)
    return true if comp == -1
    false
  end

  def winning_suit(card1, card2)
    Card::SUITS.index(card1.suit) <=> Card::SUITS.index(card2.suit)
  end

  def card_values
    cards.map{|card| card.value}
  end

  def is_royal_flush?
    is_straight_flush? && cards.any? {|card| card.type == :ace}
  end

  def is_straight_flush?
    is_flush? && is_straight?
  end

  def is_flush?
    cards.all?{ |card| card.suit == cards.first.suit }
  end

  def is_straight?
    cards.sort!
    if cards.any?{|card| card.type == :ace}
      return true if cards.all? do |card|
        (1..5).include?(card.value % 13)
      end && card_values.uniq.length==5
    end

    cards.each_with_index do |card, i|
      next if i==0
      return false unless card.value - 1 == cards[i-1].value
    end
    true
  end

  def is_4kind?
    type_hash.any?{|type, num| num == 4}
  end

  def is_fullhouse?
    is_3kind? && is_pair?
  end

  def is_3kind?
    type_hash.any?{|type, num| num == 3}
  end

  def is_2pair?
    type_hash.select{|_,num| num==2 }.length == 2
  end

  def is_pair?
    type_hash.any?{|type, num| num == 2}
  end


  def type_hash
    type_hash = Hash.new(0)
    cards.each do |card|
      type_hash[card.type] += 1
    end
    type_hash
  end

end
