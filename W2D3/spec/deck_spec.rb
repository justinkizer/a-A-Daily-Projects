require "deck"

describe Deck do

  describe "#initialize" do
    subject(:card_deck) { Deck.new }

    it "creates the standard 52 card starting deck" do
        expect(card_deck.deck.length).to eq(52)
    end

  end
end
