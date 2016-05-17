require_relative 'piece'

class Pawn < Piece
  attr_accessor :moved

  PAWN_DIR = {  :white => [[-1,-1], [-1, 0], [-1,1]],
    :black => [[1,-1], [1,0], [1,1]] }

  def initialize(color, start_pos, board)
    @value = '♟ '
    @moved = false
    super
  end

  def build_moves
    moves = []
    left_diff, forward_diff, right_diff = PAWN_DIR[@color]

    [left_diff, right_diff].each do |diff|
      capture_pos = new_position(@pos, diff)
      unless (capture_pos.nil? || @board[capture_pos].is_a?(NullPiece))
        moves << capture_pos if @board[capture_pos].color != color
      end
    end

    forward_one = new_position(@pos, forward_diff)
    moves << forward_one if empty?(forward_one)

    unless moved?
      forward_two = new_position(forward_one, PAWN_DIR[@color][1])
      moves << forward_two if empty?(forward_two)
    end

    moves
  end

  def moved?
    @moved
  end

  private
  def new_position(orig_pos, diff)
    new_pos = [orig_pos[0] + diff[0], orig_pos[1] + diff[1]]
    Board.in_bounds?(new_pos) ? new_pos : nil
  end

  def empty?(pos)
    (!pos.nil? && @board[pos].is_a?(NullPiece))
  end
end
