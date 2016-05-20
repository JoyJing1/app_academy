def my_min(arr)
  min = Float::INFINITY
  arr.each do |el|
    min = el if el <= min
  end
  min
end

list = [0,3,5,4,-5,10,1,90]
p my_min(list)

#O(n^2)
#O(n)


def largest_contiguous_subsum(arr)
  subarrays = []
  (0...arr.length).each do |i|
    (i...arr.length).each do |j|
      subarrays << arr[i..j]
    end
  end

  max_sum = -Float::INFINITY
  subarrays.each do |subarray|
    sum = subarray.inject(&:+)
    max_sum = sum if sum > max_sum
  end

  max_sum
end
#O(n^2)

list1 = [5,3,-7]
p largest_contiguous_subsum(list1)
list2 = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum(list2) # => 8 (from [7, -6, 7])

def largest_contiguous_subsum_fast(arr)
  global_max = arr.first
  prev_max = arr.first

  arr.drop(1).each do |el|
    curr_max = (prev_max + el > el) ? (prev_max + el) : el
    prev_max = curr_max
    global_max = curr_max if curr_max > global_max
  end
  global_max
end
#O(n)

puts 'Largest Contig Subsum: Fast'
p largest_contiguous_subsum_fast(list1)
p largest_contiguous_subsum_fast(list2)
p largest_contiguous_subsum_fast([1,-7,2])
p largest_contiguous_subsum_fast([1,2,-7,2])
p largest_contiguous_subsum_fast([-1,-2,-7,-2])
p largest_contiguous_subsum_fast([-1,-2,7,-2,9,-1,2,3,4,5])
p largest_contiguous_subsum_fast([11,9,7,-2,9,-11,2,3,4])
