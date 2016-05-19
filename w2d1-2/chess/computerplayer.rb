class ComputerPlayer
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

    checkmating = valid_moves.select {|key, value| value == :checkmate}
    return checkmating.first.first unless checkmating.empty?

    checking = valid_moves.select {|key, value| value == :check}
    return checking.first.first unless checking.empty?

    capturing = valid_moves.select {|key, value| value == :capture}
    return capturing.first.first unless capturing.empty?

    dangerous_capture = valid_moves.select {|key, value| value == :dangerous_capture}
    return dangerous_capture.first.first unless dangerous_capture.empty?

    dangerous_check = valid_moves.select {|key, value| value == :dangerous_check}
    return dangerous_check.first.first unless dangerous_check.empty?

    # safe = valid_moves.select {|key, value| value == :safe}
    # return safe.first.first unless safe.empty?

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
          valid_moves[[start_pos, end_pos]] = outcome(start_pos, end_pos)
        end
      end
    end
    valid_moves
  end

  def outcome(start_pos, end_pos)
    dupped_board = board.deep_dup
    opp_color = (board[start_pos].color == :white ? :black : :white)
    capture = board[end_pos].color == opp_color
    dupped_board.move!(start_pos, end_pos)

    danger = dupped_board.in_danger?(@color, end_pos)
    check_potential = dupped_board.in_check?(opp_color)

    return :checkmate if dupped_board.checkmate?(opp_color)
    return :dangerous_check if danger && check_potential
    return :check if check_potential
    return :dangerous_capture if danger && capture
    return :capture if capture
    return :safe unless danger
    :nothing
  end

  def board
    @display.board
  end

end
