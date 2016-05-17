require 'singleton'

class NullPiece
  include Singleton

  def value
    "  "
  end

  def color
  end

  def build_moves
    []
  end

end
