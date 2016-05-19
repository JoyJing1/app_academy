require_relative 'chess'
require_relative 'board'
require_relative 'cursorable'
require 'colorize'


class Display
  include Colorize, Cursorable
  attr_accessor :cursor_pos, :selected
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [6,0]
    @selected = nil
  end

  def render
    @board.grid.each_with_index do |row, i|
      row_output = [(i+1).to_s + ' ']
      row.each_with_index do |el, j|
        pos = [i,j]
        piece = @board[pos]

        row_output << colorize_square(piece, pos)
      end
      puts row_output.join('')

    end
    puts "   #{%w{A B C D E F G H}.join('  ')}"
  end


  private
  def colorize_square(piece, pos)
    curr_value = piece.value.colorize(piece.color)

    if (pos[0] + pos[1]).even? && @cursor_pos != pos && @selected != pos
      curr_value = curr_value.colorize(:background => :blue)
    elsif @cursor_pos != pos && @selected != pos
      curr_value = curr_value.colorize(:background => :light_blue)
    end

    if @cursor_pos == pos
      curr_value = curr_value.colorize(:background => :green)
    end

    if @selected == pos && @selected != @cursor_pos
      curr_value = curr_value.colorize(:background => :yellow)
    end
    curr_value
  end


end
