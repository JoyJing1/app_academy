require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = Card.all_cards
  end

  def num_cards
    cards.length
  end

  def shuffle!
    @cards.shuffle!
  end

  def draw
    raise 'Deck is empty' if @cards.empty?
    @cards.pop
  end

end
