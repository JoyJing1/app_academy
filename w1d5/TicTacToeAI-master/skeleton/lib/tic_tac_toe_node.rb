require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    #TRUE base case: board is over AND winner is opponent
    #FALSE base case: board is over AND winner is nil or us

    #TRUE recursive: player's turn && all children nodes are losers for player
    #TRUE recursive: opponent's turn && one of children nodes is a losing node
  end

  def winning_node?(evaluator)
    #TRUE base: board is over && winner is us
    #FALSE base: board is over && winner is nil or opponent

    #TRUE recursive: player's turn && one of children node is winning node for player
    #TRUE recursive: opponent's turn && all children nodes are winning nodes for player
  end


  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    #Iterate through all positions that are empty? on board
    #For each empty pos, create a node by duping the board
    #Put next_mover_mark in that pos
    #Make sure to alternate next_mover_mark
    #Set prev_move_pos
  end


end
