require "byebug"

def range_recursive(my_start,my_end)
  return [] if my_end < my_start
  return [my_start] if my_start == my_end

  range(my_start, my_end - 1) << my_end
end

def range_iterative(my_start, my_end)
  (my_start..my_end).map { |i| i }
end

def exp1(b,n)
  return nil if n < 0
  return 1 if n == 0
  return b if n == 1

  b * exp1(b, n-1)
end

def exp2(b,n)
  return nil if n < 0
  return 1 if n == 0
  return b if n == 1

  if n.even?
    prev_exp = exp2(b, n/2)
    prev_exp * prev_exp
  else
    prev_exp = exp2(b, (n-1)/2)
    b * prev_exp * prev_exp
  end
end

class Array
  def deep_dup

    self.map do |el|
      el.is_a?(Array) ? el.deep_dup : el
    end

  end
end

def fibonacci(n)
  return [] if n < 1
  return [1] if n == 1
  return [1,1] if n == 2

  prev_fib = fibonacci(n-1)
  prev_fib << prev_fib[-2] + prev_fib[-1]
end

def b_search(array, target)
  return nil if array.length <= 1 && array[0] != target

  mid_i = array.length / 2
  mid_el = array[mid_i]
  if mid_el == target
    mid_i
  elsif mid_el < target
    sub_b = b_search(array[mid_i..-1], target)
    sub_b.nil? ? nil : mid_i + sub_b
  else
    b_search(array[0...mid_i], target)
  end
end

def merge_sort(array)
  return array if array.length <= 1

  mid_i = array.length / 2
  left = array[0...mid_i]
  right = array[mid_i..-1]

  return merge(left, right) if left.length <= 1 &&
    right.length <= 1

  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)

  merge(sorted_left, sorted_right)
end

def merge(arr1, arr2)
  return arr1 if arr2.empty?
  return arr2 if arr1.empty?

  if arr1.first < arr2.first
    merge(arr1[1..-1], arr2).unshift(arr1.first)
  else
    merge(arr1, arr2[1..-1]).unshift(arr2.first)
  end
end

class Array
  def subsets
    return self if self.length <= 1

    subsets_list = [[], self]
    self.each_with_index do |el, i|

      subarray = self[0...i] + self[i+1..-1]
      new_subsets = subarray.subsets

      new_subsets.each do |set|
        if set.is_a?(Integer)
          subsets_list << [set]
        else
          set.sort!
          subsets_list << set unless subsets_list.include?(set)

          set_inc = set + [el]
          set_inc.sort!
          subsets_list << set_inc unless subsets_list.include?(set_inc)
        end
      end
    end
    subsets_list.sort
  end
end

def make_change1(total, coins)
  return [coins.first] if total == coins.first

  if total > coins.first
    sub_total = total - coins.first
    make_change1(sub_total, coins).unshift(coins.first)
  elsif total < coins.first
    make_change1(total, coins[1..-1])
  end

end


def make_change2(total, coins)
  return [coins.first] if total == coins.first
  return nil if coins.empty?
  coins.sort!.reverse!

  if total > coins.first
    sub_total = total - coins.first

    used_biggest = make_change2(sub_total, coins)
    used_biggest.unshift(coins.first) if used_biggest

    used_second = make_change2(total, coins[1..-1])
    if used_second
      return nil if used_biggest.nil?
      used_biggest.length < used_second.length ? used_biggest : used_second
    else
      used_biggest
    end

  elsif total < coins.first
    make_change2(total, coins[1..-1])
  end
end
