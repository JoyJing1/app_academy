class Card
  attr_reader :type, :suit

  SUITS = [:club, :diamond, :heart, :spade]

  TYPE_VALUE = {:two => 2,
              :three => 3,
              :four => 4,
              :five => 5,
              :six => 6,
              :seven => 7,
              :eight => 8,
              :nine => 9,
              :ten => 10,
              :jack => 11,
              :queen => 12,
              :king => 13,
              :ace => 14}

  def initialize(type, suit)
    @type, @suit = type, suit
  end

  def value
    TYPE_VALUE[type]
  end

  def self.all_cards
    all_cards = []
    SUITS.each do |suit|
      TYPE_VALUE.each do |type, _|
        all_cards << Card.new(type, suit)
      end
    end
    all_cards
  end

  def ==(card)
    type == card.type && suit == card.suit
  end

  def <=>(card)
    val_comp = value <=> card.value

    return val_comp unless val_comp == 0

    SUITS.index(suit) <=> SUITS.index(card.suit)
  end
end
