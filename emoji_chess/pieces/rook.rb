require_relative 'slidingpiece'

class Rook < SlidingPiece
  def initialize(color, start_pos, board)
    @value = (color == :black ? ' 🍦 ' : ' 🍨 ')
    super
  end

  def move_dirs
    [:north, :south, :east, :west]
  end
end
