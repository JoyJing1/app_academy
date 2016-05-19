class Array
  def my_uniq
    new_arr = []
    each do |el|
      new_arr << el unless new_arr.include?(el)
    end
    new_arr
  end

  def two_sum
    pairs = []
    0.upto(length - 2) do |idx1|
      (idx1 + 1).upto(length - 1) do |idx2|
          pairs << [idx1, idx2] if self[idx1] + self[idx2] == 0
      end
    end
    pairs
  end

  def my_transpose
    return self if none? {|el| el.is_a?(Array)}
    new_matrix = Array.new(length) {Array.new(first.length)}
    0.upto(length - 1) do |idx1|
      0.upto(first.length - 1) do |idx2|
        new_matrix[idx2][idx1] = self[idx1][idx2]
      end
    end
    new_matrix
  end

  def stock_picker
    min_price = Float::INFINITY
    max_profit = -Float::INFINITY
    max_profit_indices = [0,0]
    min_i = 0
    each_with_index do |price, i|
      curr_profit = price-min_price
      if curr_profit > max_profit
        max_profit = curr_profit
        max_profit_indices = [min_i, i]
      end
      if price < min_price
        min_price = price
        min_i = i
      end
    end

    return [0,0] if max_profit < 0
    max_profit_indices
  end



end
