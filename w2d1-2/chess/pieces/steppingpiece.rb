require_relative 'piece'

class SteppingPiece < Piece
  def build_moves(possible_moves)
    dirs_possible = possible_moves.select do |i, j|
      new_pos = [@pos[0] + i, @pos[1] + j]
      Board.in_bounds?(new_pos) &&
        (@board[new_pos].is_a?(NullPiece) || @board[new_pos].color != @color)
    end

    dirs_possible.map {|i,j| [i += @pos[0], j += @pos[1]]}
  end
end
