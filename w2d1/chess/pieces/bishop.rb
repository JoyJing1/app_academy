require_relative 'slidingpiece'

class Bishop < SlidingPiece
  def initialize(color, start_pos, board)
    @value = '♝ '
    super
  end

  def move_dirs
    [:northeast, :southeast, :southwest, :northwest]
  end
end
