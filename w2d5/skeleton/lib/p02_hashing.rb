class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = 0
    each_with_index do |el, idx|
      hash_value ^= (idx.hash + el.hash)
    end
    hash_value
  end
end

class String
  def hash
    chars.map { |char| char.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_value = 0
    to_a.sort.each do |k,v|
      k = k.to_s if k.is_a?(Symbol)
      v = v.to_s if v.is_a?(Symbol)
      hash_value ^= (k.hash + v.hash)
    end
    hash_value
  end


end
