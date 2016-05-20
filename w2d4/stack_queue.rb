class StackQueue

  def initialize
    @store = [MyStack.new, MyStack.new]
  end

  def enqueue(el)
    @store[0].push(el)
  end

  def dequeue
    el = @store[0].pop
    @store[1].push(el)
  end

  def size
    @store[0].size
  end

  def empty?
    @store[0].empty?
  end

  def max
    @store[0].max
  end

  def min
    @store[0].min
  end

end
