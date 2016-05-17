require_relative 'exceptions'
require_relative 'board'
require_relative 'display'

class Chess

attr_accessor :display

  def initialize(board = Board.new)
    @board = board
    @display = Display.new(@board)
    @board.populate
  end

  def take_turn
    start_pos = @display.move
    end_pos = @display.move
    @board.move(start_pos, end_pos)
    @display.render

  rescue CreatesCheck
    puts "Move puts King in check. Try again."
    retry
  rescue TryingToMoveNullPiece
    puts "No piece selected"
    retry
  rescue OutsideOfMoveRange
    puts "Selected piece cannot move there"
    retry
  end


end
