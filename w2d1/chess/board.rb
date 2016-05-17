require_relative 'pieces'
require_relative 'exceptions'

class Board
  include Enumerable

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.instance} }
  end

  def populate
    @grid[0] = [Rook.new(:black, [0,0], self),
                Knight.new(:black, [0,1], self),
                Bishop.new(:black, [0,2], self),
                Queen.new(:black, [0,3], self),
                King.new(:black, [0,4], self),
                Bishop.new(:black, [0,5], self),
                Knight.new(:black, [0,6], self),
                Rook.new(:black, [0,7], self)]

    @grid[1].each_with_index do |_,i|
      @grid[1][i] = Pawn.new(:black, [1,i], self)
    end

    (2..5).each do |n|
      @grid[n].each_with_index do |_,i|
        @grid[n][i] = NullPiece.instance
      end
    end

    @grid[6].each_with_index do |_,i|
      @grid[6][i] = Pawn.new(:white, [6,i], self)
    end

    @grid[7] = [Rook.new(:white, [7,0], self),
                Knight.new(:white, [7,1], self),
                Bishop.new(:white, [7,2], self),
                Queen.new(:white, [7,3], self),
                King.new(:white, [7,4], self),
                Bishop.new(:white, [7,5], self),
                Knight.new(:white, [7,6], self),
                Rook.new(:white, [7,7], self)]
  end

  def move!(start, end_pos)
    curr_piece = self[start]

    end_square = self[end_pos]
    self[start] = NullPiece.instance
    self[end_pos] = curr_piece
    curr_piece.pos = end_pos
  end

  def move(start, end_pos)
    move!(start, end_pos) if valid_move?(start, end_pos)
  end

  def in_check?(color)
    opp_color = (color == :white ? :black : :white)
    opp_pieces = player_pieces(opp_color)
    opponent_moves = possible_moves(opp_pieces)
    opponent_moves.include?(king_pos(color))
  end


  def king_pos(color)
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        return [i,j] if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def player_pieces(color)
    pieces = []
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        pieces << piece if piece.color == color
      end
    end
    pieces
  end

  def possible_moves(pieces)
    moves = []
    pieces.each do |piece|
      moves.concat(piece.build_moves)
    end
    moves
  end



  def checkmate?(color)
    return false if in_check?(color) == false

    curr_pieces = player_pieces(color)

    all_moves = []
    curr_pieces.each do |piece|
      piece.build_moves.each do |end_pos|
        all_moves << [piece.pos, end_pos]
      end
    end

    all_moves.select do |start_pos,end_pos|
      valid_move?(start_pos, end_pos)
    end.empty?
  end

  #TEST EXCEPTIONS
  def valid_move?(start_pos, new_pos)
    new_board = deep_dup
    piece = new_board[start_pos]
    raise TryingToMoveNullPiece if piece.is_a?(NullPiece)
    raise OutsideOfMoveRange unless piece.build_moves.include?(new_pos)

    new_board.move!(start_pos, new_pos)
    if new_board.in_check?(piece.color)
      raise CreatesCheck
    else
      return true
    end
  end

  def deep_dup
    dupe = Board.new

    self.grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        pos = [i,j]
        if piece.is_a?(NullPiece)
          dupe[pos] = piece
        else
          dupe[pos] = piece.dup
          dupe[pos].board = dupe
        end
      end
    end

    dupe
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
