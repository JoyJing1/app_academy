require_relative 'card'

class Board
  attr_accessor :grid

  def initialize(rows = 2, cols = 2)
    @grid = Array.new(rows) { Array.new(cols) {[]} }
  end


  def populate
    i_max = @grid.length
    j_max = @grid[0].length

    max_values = @grid.length * @grid[0].length / 2
    card_values = (1..max_values).map { |i| [i,i] }.flatten
    card_values.shuffle!

    (0...i_max).each do |i|
      (0...j_max).each do |j|
        card = Card.new(card_values.pop)
        self[i, j] = card
      end
    end
  end

  def render
    @grid.each do |row|
      display_row = []
      row.each do |card|
        display_row << card.display
      end
      puts display_row.join('  ')
    end
  end

  def won?
    @grid.each do |row|
      row.each do |card|
        return false unless card.found
      end
    end
    true
  end

  def reveal(guessed_pos)
    current_card = self[guessed_pos]
    current_card.reveal
  end


  def [](*pos)
    if pos.size == 1
      i, j = pos[0]
    else
      i, j = pos[0], pos[1]
    end
    @grid[i][j]
  end

  def []=(*pos, value)
    if pos.size == 1
      i, j = pos[0][0,1]
    else
      i, j = pos[0], pos[1]
    end
    @grid[i][j] = value
  end


end
