require_relative "card"

class Deck
  attr_reader :deck

  def initialize
    @deck = []
    setup
  end

  def setup
    create_cards("D")
    create_cards("H")
    create_cards("S")
    create_cards("C")
  end

  def create_cards(suit)
    13.times do |value|
      @deck << Card.new(suit, value + 1)
    end
  end

end
