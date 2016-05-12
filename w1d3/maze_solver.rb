require 'byebug'

class MazeSolver
  attr_accessor :start, :end, :current_pos, :direction_array

  def initialize(maze_name='ex-maze.txt')
    @maze = File.foreach(maze_name).map { |line| line.chomp.split('')}
    @direction_array = [:left, :up, :right, :down]
  end

  def set_start
      @maze.each_with_index do |row, y|
        row.each_with_index do |val, x|
          @start = [x,y] if val == 'S'
        end
      end
  end


  def set_end
      @maze.each_with_index do |row, y|
        row.each_with_index do |val, x|
          @end = [x,y] if val == 'E'
        end
      end
  end

  def find_path
    set_start
    set_end
    @current_pos = @start

    #Iterate through next_step until reach end
    until @current_pos == @end
      next_step
      p @current_pos
    end
    puts 'You solved the maze!'
    display_maze
  end

  def next_step
    #Check first direction in direction_array
    @direction_array.each do |dir|
      pos_to_check = dir_pos(@current_pos, dir)
      puts pos_to_check
      if empty?(pos_to_check)
        self[pos_to_check] == "X"
        @current_pos = pos_to_check
        @direction_array.rotate! until @direction_array.first == dir
      end
    end

  end

  #
  # def next_step
  #   #Check Left
  #   if empty?(left(@current_pos))
  #     self[left(@current_pos)] = "X"
  #     @current_pos = left(@current_pos)
  #     @direction_array.rotate! until @direction_array.first == :left
  #
  #   #Check Up
  #   elsif empty?(up(@current_pos))
  #     self[up(@current_pos)] = "X"
  #     @current_pos = up(@current_pos)
  #
  #   #Check Right
  #   elsif empty?(right(@current_pos))
  #     self[right(@current_pos)] = "X"
  #     @current_pos = right(@current_pos)
  #
  #   #Check Down
  #   elsif empty?(down(@current_pos))
  #     self[down(@current_pos)] = "X"
  #     @current_pos = down(@current_pos)
  #
  #   else
  #     debugger
  #     puts "No way out!!"
  #   end
  #
  # end
  #
  #




  def display_maze
    @maze.each do |row|
      p row
    end
  end

  def self.dir_pos(pos, dir)
    if dir == :left
      left(pos)
    elsif dir == :up
      up(pos)
    elsif dir == :right
      right(pos)
    elsif dir == :down
      up(down)
    else
      puts 'Wrong dir passd to dir_pos'
    end
  end
  #
  # def mark_dir(pos, dir)
  #   if dir == :left
  #     self[left(pos)] = 'X'
  #   elsif dir == :up
  #     self[up(pos)] = 'X'
  #   elsif dir == :right
  #     self[right(pos)] = 'X'
  #   elsif dir == :down
  #     self[up(down)] = 'X'
  #   else
  #     puts 'Wrong dir passd to mark_dir'
  #   end
  # end
  #
  # def empty_dir?(pos, dir)
  #   if dir == :left
  #     empty?(left)
  #   elsif dir == :up
  #     empty?(up)
  #   elsif dir == :right
  #     empty?(right)
  #   elsif dir == :down
  #     empty?(down)
  #   else
  #     puts "Wrong dir passed to empty_dir?"
  #   end
  # end


  def self.empty?(pos)
    self[pos] == " "
  end

  def self.left(pos)
    x,y = pos
    [x-1, y]
  end

  def self.up(pos)
    x,y = pos
    [x, y-1]
  end

  def self.right(pos)
    x,y = pos
    [x+1 , y]
  end

  def self.down(pos)
    x,y = pos
    [x, y+1]
  end

  def [](pos)
    x, y = pos
    @maze[y][x]
  end

  def []=(pos, val)
    x, y = pos
    @maze[y][x] = val
  end

end
