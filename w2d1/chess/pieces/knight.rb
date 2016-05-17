require_relative 'steppingpiece'

class Knight < SteppingPiece
  KNIGHT_MOVES =  [[1,2],
                  [2,1],
                  [2,-1],
                  [1,-2],
                  [-1,-2],
                  [-2,-1],
                  [-2,1],
                  [-1,2]]

  def initialize(color, start_pos, board)
    @value = '♞ '
    super
  end

  def build_moves
    super(KNIGHT_MOVES)
  end

end
