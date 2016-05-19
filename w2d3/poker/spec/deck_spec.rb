require 'deck'
require 'rspec'


describe Deck do
  subject(:deck) {Deck.new}
  let(:new_deck) {Deck.new}

  it 'Initializes with 52 cards' do
    expect(deck.num_cards).to eq(52)
  end

  it 'all cards are unique' do
    expect(deck.cards.uniq).to match(deck.cards)
  end

  describe '#shuffle' do
    it 'shuffles the cards in the deck' do
      expect(deck.cards).to receive(:shuffle!)
      deck.shuffle!
    end

    it 'changes the order of the cards' do
      deck.shuffle!
      expect(deck.cards.first).not_to eq(new_deck.cards.first)
    end

    it "does not add or remove cards" do
      deck.shuffle!
      expect(deck.cards.sort).to eq(new_deck.cards.sort)
    end
  end



  describe '#draw' do
    it 'draws a card from the deck' do
      expect(deck.draw).to be_an_instance_of(Card)
    end

    it 'decreases the number of cards in deck by 1' do
      deck.draw
      expect(deck.num_cards).to be(51)
    end

    it 'raises an error if the deck is empty' do
      52.times {deck.draw}
      expect {deck.draw}.to raise_error('Deck is empty')
    end
  end
end
