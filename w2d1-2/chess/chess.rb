require_relative 'chess_manifest'

class Chess

  def initialize(player1=nil, player2=nil)
    @board = Board.new
    @display = Display.new(@board)
    @board.populate
    @player1 ||= ComputerPlayer.new('White', :white, @display)
    @player2 ||= DumbComputerPlayer.new('Black', :black, @display)
    @current_player = @player1
  end

  def play
    until game_over?
      play_turn
      @board.make_promotions
      switch_players!
      sleep(0.1)
    end
    puts "#{@current_player.name}, Checkmate!"
  end

  private

  def play_turn
    @display.selected = nil
    start_pos = @current_player.move
    raise InvalidSelection if @board[start_pos].color != @current_player.color

    @display.selected = start_pos
    end_pos = @current_player.move

    @board.move(start_pos, end_pos)
    @display.selected = nil

    system('clear')
    @display.render

  rescue InvalidMove
    puts "That was an invalid move"
    sleep(1)
    retry
  rescue InvalidSelection
    puts "Please choose one of your pieces"
    sleep(1)
    retry
  rescue CreatesCheck
    puts "Move puts King in check. Try again."
    sleep(1)
    retry
  rescue TryingToMoveNullPiece
    puts "No piece selected"
    sleep(1)
    retry
  rescue OutsideOfMoveRange
    puts "Selected piece cannot move there"
    sleep(1)
    retry
  end

  def switch_players!
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end

  def game_over?
    @board.checkmate?(@current_player.color)
  end

end


if __FILE__ == $0
  Chess.new.play
end
