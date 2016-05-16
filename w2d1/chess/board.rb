class Board
  include Enumerable

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def move(start, end_pos)
    curr_piece = self[start]
    raise NoPieceSelected if curr_piece.nil?

    end_square = self[end_pos]
    raise DestinationOccupied if end_square.color == curr_piece.color

    #Capture if end_square is opp's color
    #Raise PathBlocked if can't make it there

    #Assume everything's perfect
    self[start] = nil
    self[end_pos] = curr_piece
    curr_piece.pos = end_pos

  end



  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,val)
    x,y = pos
    @grid[x][y] = val
  end

  def valid_pos?(pos)
    x,y = pos
    raise InvalidPosition unless (0..7).include?(x) &&
      (0..7).include?(y)
  end
end

class InvalidPosition < StandardError
end

class NoPieceSelected < StandardError
end

class InvalidMove < StandardError
end

class DestinationOccupied < InvalidMove
end

class PathBlocked < InvalidMove
end
