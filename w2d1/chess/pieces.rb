require 'byebug'
require 'singleton'

class Piece
  DIRS = {:north => [-1,0],
          :northeast => [-1, 1],
          :east => [0,1],
          :southeast => [1,1],
          :south => [1,0],
          :southwest => [1,-1],
          :west => [0,-1],
          :northwest => [-1,-1]}

  attr_accessor :pos, :value, :board

  def initialize(color, start_pos, board)
    @color = color
    @pos = start_pos
    @board = board
  end

  def moves
    #array of places Piece can move to
  end

end







class SlidingPiece < Piece

  def build_moves
    moves = []
    move_dirs.each do |dir|
      moves += build_move_dir(DIRS[dir])
    end
    moves
  end


  private
  def build_move_dir(diff)
    moves = []
    new_pos = [@pos[0] + diff[0], @pos[1] + diff[1]]

    while Board.in_bounds?(new_pos)
      #debugger
      new_square = @board[new_pos]

      if new_square.nil?
        moves << new_pos
      elsif new_square.color == @color
        #Stopped by own piece
        break
      elsif new_square.color != @color
        #Take opponent piece
        moves << new_pos
        break
      end
      new_pos = [new_pos[0] + diff[0], new_pos[1] + diff[1]]

    end

    moves
  end

end




class SteppingPiece < Piece
  def build_moves(possible_moves)
    dirs_possible = possible_moves.select do |i, j|
      new_pos = [@pos[0] + i, @pos[1] + j]
      Board.in_bounds?(new_pos) &&
        (@board[new_pos].nil? || @board[new_pos].color != @color)
    end

    dirs_possible.map {|i,j| [i += @pos[0], j += @pos[1]]}
  end
end


class Rook < SlidingPiece
  def initialize(color, start_pos, board)
    @value = 'R'
    super
  end

  def move_dirs
    [:north, :south, :east, :west]
  end
end

class Queen < SlidingPiece
  def initialize(color, start_pos, board)
    @value = 'Q'
    super
  end

  def move_dirs
    DIRS.keys
  end
end

class Bishop < SlidingPiece
  def initialize(color, start_pos, board)
    @value = "B"
    super
  end

  def move_dirs
    [:northeast, :southeast, :southwest, :northwest]
  end
end


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
    @value = 'N'
    super
  end

  def build_moves
    #Call SteppingPiece moves build_moves(KNIGHT_MOVES)
    super(KNIGHT_MOVES)
  end

end

class King < SteppingPiece
  def initialize(color, start_pos, board)
    @value = 'K'
    super
  end

  def build_moves
    super(DIRS.values)
  end
end


class Pawn < Piece
  PAWN_DIR = {  :light_blue => [[-1,-1], [-1, 0], [-1,1]],
    :red => [[1,-1], [1,0], [1,1]] }

  def initialize(color, start_pos, board)
    @value = 'P'
    @moved = false
    super
  end

  def build_moves
    moves = []

    left_capture = new_position(@pos, PAWN_DIR[@color].first)
    right_capture = new_position(@pos, PAWN_DIR[@color].last)
    forward_one = new_position(@pos, PAWN_DIR[@color][1])

    unless (left_capture.nil? || @board[left_capture].nil?)
      moves << left_capture if @board[left_capture].color != @color
    end

    unless (right_capture.nil? || @board[right_capture].nil?)
      moves << right_capture if @board[right_capture].color != @color
    end

    moves << forward_one if (!forward_one.nil? && @board[forward_one].nil?)

    unless moved?
      forward_two = new_position(forward_one, PAWN_DIR[@color][1])
      moves << forward_two if (!forward_two.nil? && @board[forward_two].nil?)
    end

    moves
  end



  def new_position(orig_pos, diff)
    new_pos = [orig_pos[0] + diff[0], orig_pos[1] + diff[1]]
    Board.in_bounds?(new_pos) ? new_pos : nil
  end


  def moved?
    @moved
  end

end


class NullPiece < Piece
  include Singleton

end
