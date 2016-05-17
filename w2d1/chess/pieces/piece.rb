class Piece
  attr_accessor :pos, :value, :board, :color

  DIRS = {:north => [-1,0],
          :northeast => [-1, 1],
          :east => [0,1],
          :southeast => [1,1],
          :south => [1,0],
          :southwest => [1,-1],
          :west => [0,-1],
          :northwest => [-1,-1]}

  def initialize(color, start_pos, board)
    @color = color
    @pos = start_pos
    @board = board
  end
end
