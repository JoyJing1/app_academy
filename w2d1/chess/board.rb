require_relative 'pieces_manifest'
require_relative 'exceptions'

class Board
  include Enumerable

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.instance} }
  end

  def populate
    back_row(:black, 0)
    front_row(:black, 1)

    front_row(:white, 6)
    back_row(:white, 7)
  end

  def move!(start, end_pos)
    curr_piece = self[start]

    end_square = self[end_pos]
    self[start] = NullPiece.instance
    self[end_pos] = curr_piece
    curr_piece.pos = end_pos
  end

  def move(start, end_pos)
    raise InvalidMove unless valid_move?(start, end_pos)

    if self[start].is_a?(Pawn)
      self[start].moved = true
    end
    move!(start, end_pos)
  end

  def in_check?(color)
    in_danger?(color, king_pos(color))
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

  def in_danger?(color, pos)
    opp_color = (color == :white ? :black : :white)
    opp_pieces = player_pieces(opp_color)
    opponent_moves = possible_moves(opp_pieces)
    opponent_moves.include?(pos)
  end

  def valid_move?(start_pos, new_pos)
    new_board = deep_dup
    piece = new_board[start_pos]
    raise TryingToMoveNullPiece if piece.is_a?(NullPiece)
    raise OutsideOfMoveRange unless piece.build_moves.include?(new_pos)

    new_board.move!(start_pos, new_pos)
    new_board.in_check?(piece.color) ? false : true
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

  private
  def back_row(color, row)
    @grid[row] = [Rook.new(color, [row,0], self),
                Knight.new(color, [row,1], self),
                Bishop.new(color, [row,2], self),
                Queen.new(color, [row,3], self),
                King.new(color, [row,4], self),
                Bishop.new(color, [row,5], self),
                Knight.new(color, [row,6], self),
                Rook.new(color, [row,7], self)]
  end

  def front_row(color, row)
    @grid[row].each_with_index do |_,i|
      @grid[row][i] = Pawn.new(color, [row,i], self)
    end
  end

  def possible_moves(pieces)
    moves = []
    pieces.each do |piece|
      moves.concat(piece.build_moves)
    end
    moves
  end

  def king_pos(color)
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        return [i,j] if piece.is_a?(King) && piece.color == color
      end
    end
  end

end
