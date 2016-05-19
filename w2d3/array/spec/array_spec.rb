require 'rspec'
require 'array'

describe Array do
  let(:array1) {[1,2,1,3,3]}
  let(:array2) {[5,3,1,4,7,7]}
  let(:array3) {[-1,0,2,-2,1]}
  let(:two_dim_array) { [[0,1,2],[3,4,5],[6,7,8]] }
  let(:transpoed_array) { [[0,3,6],[1,4,7],[2,5,8]] }
  let(:reverse_array) {[5,4,3,2,1]}

  describe '#my_uniq' do
    it 'removes duplicates from an array' do
      expect(array1.my_uniq).to eq([1,2,3])
    end

    it 'returns elements in the original order' do
      expect(array2.my_uniq).to eq([5,3,1,4,7])
    end
  end

  describe '#two_sum' do
    it 'finds all pairs of positions that sum to zero' do
      expect(array3.two_sum).to eq([[0,4], [2,3]])
    end

    it 'returns an empty array if there are no pairs' do
      expect(array1.two_sum).to be_empty
    end
  end

  describe '#my_transpose' do
    it 'transposes a 3x3 array' do
      expect(two_dim_array.my_transpose).to eq(transpoed_array)
    end

    it 'transposes an empty array' do
      expect([].my_transpose).to eq([])
    end

    it 'transposes an array of 1 element' do
      expect([1].my_transpose).to eq([1])
    end
  end

  describe '#stock_picker' do
    it 'outputs the most profitable pair of days to buy/sell a stock' do
      expect(array3.stock_picker).to eq([0,2])
    end

    it 'outputs the first most profitable pair of days to buy/sell a stock' do
      expect(array2.stock_picker).to eq([2, 4])
    end

    it 'outputs same day pair if there is no profitable pair of days' do
      expect(reverse_array.stock_picker).to eq([0, 0])
    end
  end
end
