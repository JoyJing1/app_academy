require_relative 'board'
require 'byebug'

class HumanPlayer

  def initialize
  end

  def prompt
    print "Which card would you like to check? "
  end

  def see_board(board)
    board.render
  end

  def get_guess
    guess = gets.chomp
    [guess[0].to_i, guess[-1].to_i]
  end

end






class ComputerPlayer
  attr_accessor :board, :known_cards

  def initialize
    @known_cards = {}
  end

  def prompt
  end

  def see_board(board)
    @board = board

    (0...@board.grid.length).each do |i|
      (0...@board.grid[0].length).each do |j|
        card = @board.grid[i][j]
        known_cards[[i, j]] = card.value if card.found
      end
    end
  end

  def get_found_pairs
    found_pairs = Hash.new(0)
    #debugger
    (0...@board.grid.length).each do |i|
      (0...@board.grid[0].length).each do |j|
        card = @board[i,j]
        if card.found
          found_pairs[card.value] += 1
        end
      end
    end
    found_pairs
  end

  def get_known_pairs
    known_pairs = Hash.new(0)
    @known_cards.each { |key, val| known_pairs[val] += 1 }
    known_pairs.select { |_, val| val == 2 }
  end


  def known_pairs
    known_pairs = get_known_pairs
    found_pairs = get_found_pairs

    found_pairs_subset = found_pairs.select {|key, val| val == 2}

    #Remove found_pairs from known_pairs
    found_pairs_subset.each do |key, _|
      known_pairs.delete(key)
    end
    known_pairs
  end

  def last_guess
    get_found_pairs.select {|key, val| val == 1}
  end

  def guess_known_pairs
    known_pairs = get_cleaned_pairs
    value = known_pairs.keys[0]

    guess_list = []
    known_cards.each do |pos, card_value|
      if card_value == value
        guess_list << pos
      end
    end

    #Remove revealed cards from guess_list
    guess_list.each do |pos|
      guess_list.delete(pos) if @board[pos].found
    end
    return guess_list.sample
  end

  def make_second_guess(last_guess)
    card_value = last_guess.keys[0]
    if known_cards.values.include?(card_value)
      return known_cards.key(card_value)
    else
      get_random_guess
    end
  end

  def get_guess
    #If computer knows two matching
    if known_pairs != {}
      guess_known_pairs

    #If computer knows remaining matching
    elsif last_guess.any?
      make_second_guess(last_guess)

    #If computer doesn't know anything
    else
      get_random_guess
    end
  end



  def get_random_guess()
    guess_list = []
    (0...@board.grid.length).each do |i|
      (0...@board.grid[0].length).each do |j|
        #If card is not found, add to possible guessing list
        card = @board.grid[i][j]
        guess_list << [i, j] unless card.found
      end
    end
    guess_list.sample
  end


end
