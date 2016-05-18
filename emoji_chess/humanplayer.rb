class HumanPlayer
  attr_accessor :color, :name

  def initialize(name, color, display)
    @name = name
    @color = color
    @display = display
  end

  def move
    result = nil

    until result
      system('clear')
      @display.render
      puts "You're in Check!!" if @display.board.in_check?(@color)
      puts "#{name}, your move!"
      result = @display.get_input
    end
    result
  end

end
