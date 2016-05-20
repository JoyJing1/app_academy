require_relative 'min_max_stack_queue'

def max_windowed_range(array, window_size)
  current_max_range = nil
  (window_size-1...array.length).each do |i|
    subarray = array[i-(window_size-1)..i]
    max = subarray.max
    min = subarray.min
    curr_range = max-min
    current_max_range = curr_range if current_max_range.nil? || curr_range > current_max_range
  end
  current_max_range
end
#O(n + 2w) ==> O(n)

p max_windowed_range([1,2,3,5], 3)


def windowed_max_range(array, window_size)
  max_range = nil
  sq = MinMaxStackQueue.new

  array.each {|el| sq.enqueue(el)}

  (array.length-window_size).times do
    (window_size).times do
      sq.dequeue
    end
    curr_range = sq.max - sq.min
    max_range = curr_range if max_range.nil? || curr_range > max_range

    (window_size - 1).times {sq.requeue}
    sq.trash_dump
  end

  max_range
end
#O(n)


p windowed_max_range([1,2,3,5], 3)
p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
