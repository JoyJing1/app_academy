require_relative 'steppingpiece'

class King < SteppingPiece
  def initialize(color, start_pos, board)
    @value = (color == :black ? ' 🎩 ' : ' 👑 ')
    super
  end

  def build_moves
    super(DIRS.values)
  end
end
