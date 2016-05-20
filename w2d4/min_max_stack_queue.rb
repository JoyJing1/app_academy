require_relative 'stack'

class MinMaxStackQueue

  def initialize
    @store = [MyStack.new, MyStack.new]
  end

  def enqueue(el)
    @store[0].push(el)
  end

  def dequeue
    el = @store[0].pop
    @store[1].push(el)
    el
  end

  def requeue
    el = @store[1].pop
    @store[0].push(el)
  end

  def trash_dump
    @store[1] = MyStack.new
  end

  def size
    @store[0].size
  end

  def empty?
    @store[0].empty?
  end

  def max
    @store[1].max
  end

  def min
    @store[1].min
  end

end
