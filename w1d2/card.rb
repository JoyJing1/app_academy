class Card
  attr_accessor :found
  attr_reader :value

  def initialize(value)
    @value = value
    @found = false
  end

  def display
    @found ? to_s : hide
  end

  def to_s
    self.value.to_s
  end

  def reveal
    to_s
  end

  def hide
    "X"
  end

  def ==(card)
    @value == card.value
  end

end
