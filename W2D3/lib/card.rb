class Card
  attr_reader :color, :suit, :value

  def initialize(suit, value)
    @suit = suit
    @color = (@suit == "D" || @suit == "H" ? :red : :black)
    @value = value
  end

end
