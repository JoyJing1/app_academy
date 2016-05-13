require 'byebug'

class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    return if self.parent == new_parent
    unless self.nil? || new_parent.nil?
      unless new_parent.children.include?(self)
        new_parent.children << self
      end
    end

    unless @parent.nil?
      @parent.children.delete(self)
    end

    @parent = new_parent
  end




  def add_child(child_node)
    child_node.parent=self
  end

  def remove_child(child)
    if children.include?(child)
      @children.delete(child)
      child.parent=nil
    else
      raise Exception.new('Node is not a child')
    end
  end

  def dfs(target)
    return self if value == target
    #puts "DFS current val: #{value}" unless self.nil?

    children.each do |child|
      result = child.dfs(target)

      return result unless result.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      el = queue.shift
      #puts "BFS current val: #{el.value}" unless el.nil?
      return el if el.value == target
      el.children.each { |child| queue << child }
    end

  end


end
