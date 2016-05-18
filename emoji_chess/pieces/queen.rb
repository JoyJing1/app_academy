require_relative 'slidingpiece'

class Queen < SlidingPiece
  def initialize(color, start_pos, board)
    @value = (color == :black ? ' 🍺 ' : ' 🍷 ')
    super
  end

  def move_dirs
    DIRS.keys
  end
end
