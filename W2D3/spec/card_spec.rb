require "card"

describe Card do

  describe "#initialize" do
    subject(:card) { Card.new(:red, "D", 1)}

    it "should initialize with a color, suit, and value" do
        expect(card.color).to eq(:red)
        expect(card.suit).to eq("D")
        expect(card.value).to eq(1)
    end

  end

end
