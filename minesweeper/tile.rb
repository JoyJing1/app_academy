class Tile
  attr_accessor :flagged, :bomb, :revealed

  def initialize(bomb)
    @bomb = bomb
    @flagged = false
    @revealed = false
  end

  def self.make_tiles(total_tiles=81, num_bombs=10)
    tiles = (0...num_bombs).map{|_| true}
    (0...(total_tiles-num_bombs)).map do |_|
      tiles << false
    end
    tiles.shuffle.map{ |i| Tile.new(i) }
  end

  def reveal
    @revealed = true
  end

  def flagged?
    flagged
  end

  def revealed?
    revealed
  end

  def has_bomb?
    bomb
  end
end
