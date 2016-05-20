require 'byebug'

class MyStack

  def initialize
    @store = []
    @max = []
    @min = []
  end

  def push(el)
    @store.push(el)
    add_limits(el)
  end

  def pop
    el = @store.pop
    remove_limits(el)
    el
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def add_limits(el)
    #debugger
    @max << el if @max.empty? || el >= @max.last
    @min << el if @min.empty? || el <= @min.last
  end

  def remove_limits(el)
    @max.pop if el == @max.last
    @min.pop if el == @min.last
  end

  def max
    @max.last
  end

  def min
    @min.last
  end

end
