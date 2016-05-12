require 'set'

class WordChainer
  attr_accessor :dictionary

  def initialize(dictionary_file_name='dictionary.txt')
    dict = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = dict.to_set
  end

  def adjacent_words(word)
    @dictionary.select { |d_word| word.adj_word?(d_word) }
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    until @current_words.empty?
      break if @all_seen_words.include?(target)
      new_current_words = explore_current_words
      @current_words = new_current_words
    end

    build_path(target)
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        unless @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end
    end

    new_current_words.each do |current_word|
      puts "#{current_word} <= #{@all_seen_words[current_word]}"
    end

    new_current_words
  end

  def build_path(target)
    return [] if target.nil?
    previous_word = @all_seen_words[target]
    build_path(previous_word) << previous_word
  end

end





class String
  def remove_char(i)
    self.slice(0, i) + self.slice(i+1, self.length-1)
  end

  def adj_word?(word)
    if word.length == self.length && word != self
      word.chars.each_with_index do |_, i|
        return true if word.remove_char(i) == self.remove_char(i)
      end
    end
    false
  end

end
