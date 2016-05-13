require_relative 'tile'
require 'byebug'

class Board
  attr_accessor :grid, :lost

  def initialize(dim=9)
    @grid = Array.new(dim) { Array.new(dim) {[]} }
    @lost = false
  end

  def populate(total_tiles, num_bombs)
    tiles = Tile.make_tiles(total_tiles, num_bombs)
    tiles.each_with_index do |tile, i|
      row = i / dim
      col = i % dim
      self[[row, col]] = tile
    end
  end

  def neighboring_bombs(pos)
    num_bombs = 0
    x,y = pos
    ((x-1)..(x+1)).each do |i|
      ((y-1)..(y+1)).each do |j|
        next unless valid_pos?([i,j])
        neighbor_tile = self[[i,j]]
        next if neighbor_tile.nil? || (i == x && j == y)
        if neighbor_tile.has_bomb?
          num_bombs += 1
        end
      end
    end
    num_bombs
  end

  def display
    @grid.each do |row|
      row.each do |tile|
        print " #{tile.bomb} "
      end
      puts
    end
  end

  def show_board
    @grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if tile.flagged?
          print " F "
        elsif tile.revealed? && !tile.has_bomb?
          near_bombs = neighboring_bombs([i,j])
          print near_bombs == 0 ? " _ " : " #{near_bombs} "
        elsif tile.has_bomb? && @lost==true
          print " X "
        elsif !tile.revealed?
          print " * "
        else
          print "Something went wrong at ()#{i}, #{j})!"
        end
      end
      puts
    end
  end

  def valid_pos?(pos)
    x,y = pos
    (0...dim).include?(x) && (0...dim).include?(y)
  end

  def dim
    @grid.length
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x,y = pos
    @grid[x][y] = val
  end

end
