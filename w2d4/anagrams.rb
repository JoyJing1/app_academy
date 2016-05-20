
def first_anagram?(string1, string2)
  anagrams = string1.chars.permutation.map { |chs| chs.join('') }
  anagrams.include?(string2)
end
# O(n!)

def second_anagram?(string1, string2)
  chars1 = string1.chars
  chars2 = string2.chars

  chars1.each_with_index do |char1, idx1|
     chars2.each_with_index do |char2, idx2|
        if char1 == char2
          chars1.delete_at(idx1)
          chars2.delete_at(idx2)
        end
     end
  end

  chars1 == chars2
end
# O(n^2)

def third_anagram?(string1, string2)
  # calls on Array::sort, which uses quick-sort (O(nlogn) - avg; O(n^2) - worst case)
  string1.chars.sort == string2.chars.sort
end
# O(nlogn)

def fourth_anagram?(string1, string2)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)

  string1.chars.each { |char| hash1[char] += 1 }
  string2.chars.each { |char| hash2[char] += 1 }

  hash1 == hash2
end
# O(n)

def fifth_anagram?(string1, string2)
  letters_hash = Hash.new(0)

  string1.chars.each { |char| letters_hash[char] += 1 }
  string2.chars.each do |char|
    letters_hash[char] > 0 ? letters_hash[char] -= 1 : (return false)
  end

  true
end
# O(n)


puts 'Anagrams!'
# p first_anagram?("gizmo", "sally")    #=> false
# p first_anagram?("elvis", "lives")    #=> true


# p second_anagram?("gizmo", "sally")    #=> false
# p second_anagram?("elvis", "lives")

#
# p third_anagram?("gizmo", "sally")    #=> false
# p third_anagram?("elvis", "lives")    #=> true
#
# p fourth_anagram?("gizmo", "sally")    #=> false
# p fourth_anagram?("elvis", "lives")    #=> true

p fifth_anagram?("gizmo", "sally")    #=> false
p fifth_anagram?("elvis", "lives")    #=> true
