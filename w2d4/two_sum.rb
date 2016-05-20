def bad_two_sum?(arr, target_sum)
  (0...arr.length-1).each do |i|
    (i+1...arr.length).each do |j|
      return true if arr[i] + arr[j] == target_sum
    end
  end
  false
end
#O(n^2)


def okay_two_sum?(arr, target_sum)
  arr.sort!

  arr.each_with_index do |el, i|
    remainder = target_sum - el
    subarray = arr[0...i] + arr[i+1..-1]

    return true unless binary_search(subarray, remainder).nil?
  end
  false
end
#O(nlogn)

def binary_search(arr, target)
  return 0 if arr.length == 1 && arr.first == target
  return nil if arr.length <= 1

  mid = arr.length/2
  left, right = arr.take(mid), arr.drop(mid)

  if right.first <= target
    bsearch = binary_search(right, target)
    return bsearch + mid unless bsearch.nil?
  else
    bsearch = binary_search(left, target)
    return bsearch unless bsearch.nil?
  end
  nil
end
#O(logn) - binary search


def great_two_sum?(arr, target_sum)
  hash = Hash.new(0)

  arr.each do |el|
    remainder = target_sum - el
    return true if hash[remainder] > 0
    hash[el] += 1
  end
  false
end
#O(n)

def sum_four?(arr, target_sum)
  two_sums = []
  arr.take(arr.length-1).each_with_index do |el1, i|
    arr[i+1..-1].each do |el2|
      two_sums << el1+el2
    end
  end

  great_two_sum?(two_sums, target_sum)
end


p bad_two_sum?([0,1,5,7], 6)
p bad_two_sum?([0,1,5,7], 10)
p okay_two_sum?([0,1,5,7], 6)
p okay_two_sum?([0,1,5,7], 10)
p great_two_sum?([0,1,5,7], 6)
p great_two_sum?([0,1,5,7], 10)

p four_sum?([1,4,2,5], 12)
p four_sum?([-3,-4,4,1,4,2,5], 12)
p four_sum?([1,4,2,5,4,1,3], 12)
p four_sum?([], 12)
p four_sum?([1], 1)
