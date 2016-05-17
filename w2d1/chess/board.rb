class Board
  include Enumerable

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    #Populate board
  end

  def populate
    #red back row
    @grid[0] = [Rook.new(:red, [0,0], self),
                Knight.new(:red, [0,1], self),
                Bishop.new(:red, [0,2], self),
                Queen.new(:red, [0,3], self),
                King.new(:red, [0,4], self),
                Bishop.new(:red, [0,5], self),
                Knight.new(:red, [0,6], self),
                Rook.new(:red, [0,7], self)]

    #red pawn row
    @grid[1].each_with_index do |_,i|
      @grid[1][i] = Pawn.new(:red, [1,i], self)
    end

    #empty rows
    #DO THIS ON TUES
    (2..5).each do |n|
      @grid[n].each_with_index do |_,i|
        @grid[n][i] = NullPiece.instance

    #light blue pawn row
    @grid[6].each_with_index do |_,i|
      @grid[6][i] = Pawn.new(:light_blue, [6,i], self)
    end

    #light blue back row
    @grid[7] = [Rook.new(:light_blue, [7,0], self),
                Knight.new(:light_blue, [7,1], self),
                Bishop.new(:light_blue, [7,2], self),
                Queen.new(:light_blue, [7,3], self),
                King.new(:light_blue, [7,4], self),
                Bishop.new(:light_blue, [7,5], self),
                Knight.new(:light_blue, [7,6], self),
                Rook.new(:light_blue, [7,7], self)]

  end

  def move(start, end_pos)
    curr_piece = self[start]
    # raise NoPieceSelected if curr_piece.nil?

    end_square = self[end_pos]
    # raise DestinationOccupied if end_square.color == curr_piece.color

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

  def self.in_bounds?(pos)
    x,y = pos
    (0..7).include?(x) && (0..7).include?(y)

  end
end
#
# class InvalidPosition < StandardError
# end
#
# class NoPieceSelected < StandardError
# end
#
# class InvalidMove < StandardError
# end
#
# class DestinationOccupied < InvalidMove
# end
#
# class PathBlocked < InvalidMove
# end
