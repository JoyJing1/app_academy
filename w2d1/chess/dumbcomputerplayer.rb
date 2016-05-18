class DumbComputerPlayer
  attr_accessor :name, :color

  def initialize(name, color, display)
    @name, @color, @display = name, color, display
  end

  def move
    if @display.selected
      return @end_pos
    else
      @start_pos, @end_pos = get_move
    end
    @start_pos
  end

  def get_move
    valid_moves = move_search
    valid_moves.keys.sample
  end

  private
  def move_search
    curr_pieces = board.player_pieces(@color)

    valid_moves = {}
    curr_pieces.each do |piece|
      all_moves = piece.build_moves.map { |end_pos| [piece.pos, end_pos] }

      all_moves.each do |start_pos, end_pos|
        if board.valid_move?(start_pos, end_pos)
          valid_moves[[start_pos, end_pos]] = :dummy
        end
      end
    end
    valid_moves
  end

  def board
    @display.board
  end
end
