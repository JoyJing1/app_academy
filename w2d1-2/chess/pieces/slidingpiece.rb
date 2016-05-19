require_relative 'piece'

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
      new_square = @board[new_pos]

      if new_square.is_a?(NullPiece)
        moves << new_pos
      elsif new_square.color == @color
        break
      elsif new_square.color != @color
        moves << new_pos
        break
      end
      new_pos = [new_pos[0] + diff[0], new_pos[1] + diff[1]]

    end

    moves
  end

end
