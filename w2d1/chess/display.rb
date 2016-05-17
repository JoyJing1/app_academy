require_relative 'chess'
require_relative 'board'
require_relative 'cursorable'
require 'colorize'


class Display
  include Colorize, Cursorable
  attr_accessor :cursor_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = false
  end

  def render
    @board.grid.each_with_index do |row, i|
      row_output = []
      row.each_with_index do |el, j|
        pos = [i,j]
        piece = @board[pos]

        if piece.nil?
          curr_value = '  '
        else
          curr_value = piece.value.colorize(piece.color)
        end

        if (i + j) % 2 == 1 && @cursor_pos != pos
          curr_value = curr_value.colorize(:background => :blue)
        end

        if @cursor_pos == pos
          curr_value = curr_value.colorize(:background => :green)
        end
        row_output << curr_value

      end
      puts row_output.join('')

    end
  end

  def move
    result = nil
    until result
      self.render
      result = self.get_input
    end
    result
  end


end
