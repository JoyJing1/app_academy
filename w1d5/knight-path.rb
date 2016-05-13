require_relative 'DataStructure'

class KnightPathFinder
  attr_accessor :visited_positions, :start, :nodes

  NEXT_POS = [[-2,1],
              [-1,2],
              [1,2],
              [2,1],
              [2,-1],
              [1,-2],
              [-1,-2],
              [-2,-1]]

  def initialize(pos)
    @start = PolyTreeNode.new(pos)
    @visited_positions = [pos]
    @nodes = [@start]
    build_move_tree
  end

  def build_move_tree
    queue = [@start]

    until queue.empty?
      curr_node = queue.shift
      next_positions = new_move_positions(curr_node.value)

      next_positions.each do |n_pos|
        n_node = PolyTreeNode.new(n_pos)
        n_node.parent = curr_node
        @nodes << n_node
        queue << n_node
      end
    end

  end

  def find_path_dfs(start_node, end_pos)
      return [start_node.value] if start_node.value == end_pos
      start_node.children.each do |child|
        path = find_path_dfs(child, end_pos)
        return path.unshift(start_node.value) unless path.nil?
      end
      nil
  end

  def find_path_bfs(end_pos)
    end_node = @start.bfs(end_pos)
    return nil if end_node.nil?

    ancestors = [end_node]
    until ancestors.last == @start
      ancestors << ancestors.last.parent
    end
    ancestors.reverse.map { |node| node.value }
  end

  def self.valid_moves(pos)
    x,y = pos
    valid = []
    NEXT_POS.each do |x_dif, y_dif|
      i = x + x_dif
      j = y + y_dif

      valid << [i,j] if (0...8).include?(i) && (0...8).include?(j)
    end
    valid
  end

  def new_move_positions(pos)
    new_pos = KnightPathFinder.valid_moves(pos)
    new_moves = new_pos - @visited_positions
    @visited_positions.concat(new_moves)
    new_moves
  end


end
