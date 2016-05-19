require 'card'
require 'rspec'

describe Card do
  context 'card is a numeric card' do
    let(:card) {Card.new(:five, :heart)}

    it 'returns its type' do
      expect(card.type).to eq(:five)
    end

    it 'returns its suit' do
      expect(card.suit).to eq(:heart)
    end

    it 'returns its value' do
      expect(card.value).to eq(5)
    end
  end

  context 'card is a face card' do
    let(:card) {Card.new(:king, :spade)}

    it 'returns its type' do
      expect(card.type).to eq(:king)
    end

    it 'returns its suit' do
      expect(card.suit).to eq(:spade)
    end

    it 'returns its value' do
      expect(card.value).to eq(13)
    end
  end

  context 'card is an ace' do
    let(:card) {Card.new(:ace, :club)}

    it 'returns its type' do
      expect(card.type).to eq(:ace)
    end

    it 'returns its suit' do
      expect(card.suit).to eq(:club)
    end

    it 'returns its value' do
      expect(card.value).to eq(14)
    end
  end

  describe '::all_cards' do
    let(:all_cards) {Card.all_cards}

    it 'creates a list of all 52 cards' do
      expect(all_cards.sample).to be_an_instance_of(Card)
      expect(all_cards.length).to eq(52)
      expect(all_cards.uniq).to eq(all_cards)
    end
  end

  describe '#==' do
    let(:card1) {Card.new(:king, :diamond)}
    let(:card2) {Card.new(:king, :diamond)}
    let(:card3) {Card.new(:queen, :spade)}

    it 'returns true for two equal cards' do
      expect(card1==card2).to be true
      expect(card1==card3).to be false
    end
  end

  describe '#<=>' do
    let(:card1) {Card.new(:ace, :club)}
    let(:card2) {Card.new(:ace, :spade)}
    let(:card3) {Card.new(:two, :spade)}

    it 'values spades over clubs' do
      expect(card1 <=> card2).to be -1
    end

    it 'values ace over two' do
      expect(card3<=>card2).to be -1
    end
  end

end
