require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    self[key] << key
    @count += 1
  end

  def include?(key)
    #debugger
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num.hash % num_buckets
    @store[i]
  end

  def []=(num1, num2)
    i = num1.hash % num_buckets
    @store[i] = num2
  end

  def num_buckets
    @store.length
  end

  def resize!
    return if @count < num_buckets
    new_size = 2 * num_buckets
    new_store = Array.new(new_size) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        i = el.hash % new_size
        new_store[i] << el
      end
    end
    @store = new_store
  end

end
