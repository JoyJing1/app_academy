require 'rspec'
require 'hand'


describe Hand do
  subject(:hand) {Hand.new}
  let(:card1) {Card.new(:ten, :spade)}
  let(:card2) {Card.new(:nine, :spade)}
  let(:card3) {Card.new(:eight, :spade)}
  let(:card4) {Card.new(:seven, :spade)}
  let(:card5) {Card.new(:six, :spade)}
  let(:card6) {Card.new(:five, :spade)}
  let(:cards) {[card1, card2, card3, card4, card5]}

  it 'initializes with an empty hand' do
    expect(hand).to be_empty
  end

  describe '#add_card' do
    it 'adds a card to the hand' do
      hand.add_card(card1)
      expect(hand).not_to be_empty
      expect(hand.include?(card1)).to be true
    end

    it 'raises an error if picking >5 cards' do
      cards.each {|card| hand.add_card(card) }
      expect{hand.add_card(card6)}.to raise_error('Too many cards!')
    end

    it 'raises an error if card is already in hand' do
      hand.add_card(card1)
      expect{hand.add_card(card1)}.to raise_error('Card already in hand')
    end

  end

  describe '#remove_card' do
    before(:each) do
      cards.each {|card| hand.add_card(card)}
    end

    it 'return the removed card' do
      expect(hand.remove_card(card1)).to be(card1)
    end

    it 'removes card from hand' do
      hand.remove_card(card1)
      expect(hand.num_cards).to eq(4)
    end

    it 'raises an error if hand is empty' do
      cards.each {|card| hand.remove_card(card) }
      expect{hand.remove_card(card1)}.to raise_error('Hand is empty')
    end

    it 'raises an error if card is not in current hand' do
      expect{hand.remove_card(card6)}.to raise_error('Card not in hand')
    end
  end

  let(:royal_flush) {Hand.new([Card.new(:ace, :spade), Card.new(:king, :spade),
    Card.new(:queen, :spade), Card.new(:jack, :spade), Card.new(:ten, :spade)])}
  let(:straight_flush) {Hand.new([Card.new(:seven, :spade), Card.new(:three, :spade),
    Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:six, :spade)])}
  let(:straight) {Hand.new([Card.new(:seven, :heart), Card.new(:three, :spade),
    Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:six, :spade)])}
  let(:straight_ace) {Hand.new([Card.new(:two, :heart), Card.new(:three, :spade),
    Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:ace, :spade)])}
  let(:flush) {Hand.new([Card.new(:two, :spade), Card.new(:eight, :spade),
    Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:six, :spade)])}
  let(:four_kind) {Hand.new([Card.new(:ace, :spade), Card.new(:ace, :heart),
    Card.new(:ace, :diamond), Card.new(:ace, :club), Card.new(:six, :spade)])}
  let(:full_house) {Hand.new([Card.new(:ace, :spade), Card.new(:ace, :heart),
    Card.new(:three, :diamond), Card.new(:three, :club), Card.new(:three, :spade)])}
  let(:three_kind) {Hand.new([Card.new(:three, :spade), Card.new(:three, :heart),
    Card.new(:three, :diamond), Card.new(:five, :club), Card.new(:six, :spade)])}
  let(:two_pair) {Hand.new([Card.new(:two, :spade), Card.new(:two, :heart),
    Card.new(:four, :diamond), Card.new(:four, :club), Card.new(:six, :spade)])}
  let(:one_pair) {Hand.new([Card.new(:three, :spade), Card.new(:three, :heart),
    Card.new(:four, :diamond), Card.new(:ace, :club), Card.new(:six, :spade)])}
  let(:bad_hand) {Hand.new([Card.new(:two, :heart), Card.new(:ace, :club),
    Card.new(:three, :heart), Card.new(:seven, :spade), Card.new(:six, :club)])}

  describe "#is_flush?" do
    it 'positively detects a flush' do
      expect(flush.is_flush?).to be true
    end

    it 'does not falsely detect a flush' do
      expect(bad_hand.is_flush?).to be false
    end
  end

  describe '#is_straight?' do
    it 'positively detects a straight' do
      expect(straight.is_straight?).to be true
    end

    it 'does not falsely detect a straight' do
      expect(bad_hand.is_straight?).to be false
    end
  end

  describe '#is_4kind?' do
    it 'positively detects a four of a kind' do
      expect(four_kind.is_4kind?).to be true
    end

    it 'does not falsely detect a four of a kind' do
      expect(bad_hand.is_4kind?).to be false
    end
  end

  describe '#is_fullhouse?' do
    it 'positively detects a full house' do
      expect(full_house.is_fullhouse?).to be true
    end

    it 'does not falsely detect a full house' do
      expect(bad_hand.is_fullhouse?).to be false
    end
  end

  describe '#is_3kind?' do
    it 'positively detects a three of a kind' do
      expect(three_kind.is_3kind?).to be true
    end

    it 'does not falsely detect a three of a kind' do
      expect(bad_hand.is_3kind?).to be false
    end
  end

  describe '#is_2pair?' do
    it 'positively detects a two-pair' do
      expect(two_pair.is_2pair?).to be true
    end

    it 'does not falsely detect a two-pair' do
      expect(bad_hand.is_2pair?).to be false
    end
  end

  describe '#is_pair?' do
    it 'positively detects a pair' do
      expect(one_pair.is_pair?).to be true
    end

    it 'does not falsely detect a pair' do
      expect(bad_hand.is_pair?).to be false
    end
  end

  describe '#best_hand' do
    describe  "detects hand's best combination of cards" do
      it 'detects a royal flush' do
        expect(royal_flush.best_hand).to be :royal_flush
      end

      it 'detects a straight flush' do
        expect(straight_flush.best_hand).to be :straight_flush
      end

      it 'detects a flush' do
        expect(flush.best_hand).to be :flush
      end

      it 'detects a straight' do
        expect(straight.best_hand).to be :straight
      end

      it 'detects an Ace-5 flush' do
        expect(straight_ace.best_hand).to be :straight
      end

      it 'detects a four of a kind' do
        expect(four_kind.best_hand).to be :four_kind
      end

      it 'detects a full house' do
        expect(full_house.best_hand).to be :full_house
      end

      it 'detects a three of a kind' do
        expect(three_kind.best_hand).to be :three_kind
      end

      it 'detects a two pair' do
        expect(two_pair.best_hand).to be :two_pair
      end

      it 'detects a one pair' do
        expect(one_pair.best_hand).to be :one_pair
      end

      it 'returns high card if there is no other hand' do
        expect(bad_hand.best_hand).to be :highcard
      end
    end
  end

  describe '#beats?' do
    context 'when comparing two different hands' do
      it 'royal flush beats a straight flush' do
        expect(royal_flush.beats?(straight_flush)).to be true
      end

      it 'straight flush beats a flush' do
        expect(straight_flush.beats?(flush)).to be true
      end

      it 'flush beats a straight' do
        expect(flush.beats?(straight)).to be true
      end

      it 'straight beats a four of a kind' do
        expect(straight.beats?(four_kind)).to be true
      end

      it 'four of a kind beats a full house' do
        expect(four_kind.beats?(full_house)).to be true
      end

      it 'full house beats a three of a kind' do
        expect(full_house.beats?(three_kind)).to be true
      end

      it 'three of a kind beats a two pair' do
        expect(three_kind.beats?(two_pair)).to be true
      end

      it 'two pair beats a one pair' do
        expect(two_pair.beats?(one_pair)).to be true
      end

      it 'one pair beats a highcard' do
        expect(one_pair.beats?(bad_hand)).to be true
      end

      it 'bad hand loses to royal flush' do
        expect(bad_hand.beats?(royal_flush)).to be false
      end
    end

    context 'when comparing two similar hands' do
      let(:royal_flush2) {Hand.new([Card.new(:ace, :heart), Card.new(:king, :heart),
        Card.new(:queen, :heart), Card.new(:jack, :heart), Card.new(:ten, :heart)])}
      let(:straight_flush2) {Hand.new([Card.new(:two, :spade), Card.new(:three, :spade),
        Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:six, :spade)])}
      let(:straight2) {Hand.new([Card.new(:two, :heart), Card.new(:three, :spade),
        Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:six, :spade)])}
      let(:straight_ace2) {Hand.new([Card.new(:two, :heart), Card.new(:three, :spade),
        Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:ace, :spade)])}
      let(:flush2) {Hand.new([Card.new(:two, :spade), Card.new(:seven, :spade),
        Card.new(:four, :spade), Card.new(:five, :spade), Card.new(:six, :spade)])}
      let(:four_kind2) {Hand.new([Card.new(:two, :spade), Card.new(:two, :heart),
        Card.new(:two, :diamond), Card.new(:two, :club), Card.new(:six, :spade)])}
      let(:full_house2) {Hand.new([Card.new(:two, :spade), Card.new(:two, :heart),
        Card.new(:three, :diamond), Card.new(:three, :club), Card.new(:three, :spade)])}
      let(:three_kind2) {Hand.new([Card.new(:two, :spade), Card.new(:two, :heart),
        Card.new(:two, :diamond), Card.new(:five, :club), Card.new(:six, :spade)])}
      let(:two_pair2) {Hand.new([Card.new(:two, :spade), Card.new(:two, :heart),
        Card.new(:three, :diamond), Card.new(:three, :club), Card.new(:six, :spade)])}
      let(:one_pair2) {Hand.new([Card.new(:two, :spade), Card.new(:two, :heart),
        Card.new(:four, :diamond), Card.new(:three, :club), Card.new(:six, :spade)])}
      let(:bad_hand2) {Hand.new([Card.new(:two, :spade), Card.new(:eight, :heart),
        Card.new(:three, :diamond), Card.new(:seven, :club), Card.new(:six, :spade)])}

      it 'correctly indentifies winning royal flush' do
        expect(royal_flush.beats?(royal_flush2)).to be true
      end

      it 'correctly indentifies winning straight flush' do
        expect(straight_flush.beats?(straight_flush2)).to be true
      end

      it 'correctly indentifies winning flush' do
        expect(flush.beats?(flush2)).to be true
      end

      it 'correctly indentifies winning straight' do
        expect(straight.beats?(straight2)).to be true
      end

      it 'correctly indentifies winning four kind' do
        expect(four_kind.beats?(four_kind2)).to be true
      end

      it 'correctly indentifies winning full house' do
        expect(full_house.beats?(full_house2)).to be true
      end

      it 'correctly indentifies winning three kind' do
        expect(three_kind.beats?(three_kind2)).to be true
      end

      it 'correctly indentifies winning two pair' do
        expect(two_pair.beats?(two_pair2)).to be true
      end

      it 'correctly indentifies winning one pair' do
        expect(one_pair.beats?(one_pair2)).to be true
      end

      it 'correctly indentifies winning high card' do
        expect(bad_hand2.beats?(bad_hand)).to be false
      end
    end

  end
end
