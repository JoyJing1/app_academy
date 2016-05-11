require_relative 'board'
require_relative 'player'
require 'byebug'

class Game
  attr_accessor :board

  def initialize(player=nil, board=nil)
    @board = board || Board.new
    @player = player || ComputerPlayer.new
  end


  def play_turn
    #debugger
    @player.see_board(board)
    #board.render
    @previous_guess = nil

    #Check whether card has been revealed
    first_card = Card.new(0)
    first_card.found = true
    until first_card.found == false
      board.render
      #debugger
      @player.prompt
      guess1 = @player.get_guess
      first_card = @board[guess1]
      #debugger
      if first_card.found #loop again
        puts "That card has already been revealed"
        debugger
      end
      #debugger
    end
    puts "First card value: #{first_card.value}"

    #Display board until guess
    first_card.found = true
    #board.render
    @player.see_board(board)

    @previous_guess = guess1

    second_card = Card.new(0)
    second_card.found = true
    until second_card.found == false
      board.render
      @player.prompt
      guess2 = @player.get_guess
      second_card = self.board[guess2]
      if second_card.found
        debugger
        puts "That card has already been revealed"

      end
    end
    puts "Second card value: #{second_card.value}"

    #Display board for 2 secs
    second_card.found = true
    #board.render
    @player.see_board(board)

    if first_card == second_card
      puts "Yay, they match!"
    else
      first_card.found = false
      second_card.found = false
    end

    sleep(2)
    system("clear")
  end


def play
  @board.populate
  puts "Try to find all of the matching cards.".center(50)
  puts "Type in all coordinates in the format: 0,0".center(50)
  until @board.won?
    play_turn
  end
  puts "Yay you won! Congrats"
  @board.render
end

  private
  attr_accessor :previous_guess, :player

end
