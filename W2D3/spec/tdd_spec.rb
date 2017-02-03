require 'tdd'

#

describe "#my_uniq" do

  it "should ONLY take an array" do
    expect { my_uniq([1]) }.to_not raise_error
    expect { my_uniq(5) }.to raise_error("Array input required.")
  end

  it "should ONLY return an array" do
    expect(my_uniq([1,2,3])).to be_an(Array)
  end

  it "should ONLY return unique elements in their original order" do
    expect(my_uniq([1,3,2,2,3,1])).to eq([1,3,2])
  end

end

describe "#two_sum" do

  it "should ONLY take an array" do
    expect { two_sum([-1, 0, 2, -2, 1]) }.to_not raise_error
    expect { two_sum(5) }.to raise_error("Array input required.")
  end

  it "should ONLY return an array" do
    expect(two_sum([1,2,3])).to be_an(Array)
  end

  it "should return an empty array if no two numbers sum up to zero" do
    expect(two_sum([1,2,3])).to eq([])
  end

  it "should return an array of sorted index pairs" do
    expect(two_sum([-1, 0, 2, -2, 1])).to eq([[0, 4], [2, 3]])
  end

end

describe "#my_transpose" do
  let(:rows) {
    [[0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]]
  }
  let(:columns) {
    [[0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]]
  }

  it "should ONLY take an array" do
    expect { my_transpose([1]) }.to_not raise_error
    expect { my_transpose(5) }.to raise_error("Array input required.")
  end

  it "should ONLY return an array" do
    expect(my_transpose([1,2,3])).to be_an(Array)
  end

  it "should convert rows to columns" do
    expect(my_transpose(rows)).to eq(columns)
  end

  it "should convert columns to rows" do
    expect(my_transpose(columns)).to eq(rows)
  end

end

describe "#stock_picker" do

  it "should ONLY take an array" do
    expect { stock_picker([300, 500, 900, 600]) }.to_not raise_error
    expect { stock_picker(5) }.to raise_error("Array input required.")
  end

  it "should ONLY return an array" do
    expect(stock_picker([1,2,3])).to be_an(Array)
  end

  it "should return an array of indices most profitable pair of days" do
    expect(stock_picker([300, 400, 100, 500, 200, 800])).to eq([2, 5])
  end

  it "should return an empty array if there are no profitable days" do
    expect(stock_picker([300, 300, 200, 100, 50])).to eq([])
  end

  it "should not try to sell stock before it's purchased" do
    expect(stock_picker([300, 3000, 100, 500, 200, 800])).to eq([0, 1])
  end

end

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }

  describe "#initialize" do

    it "should initialize empty middle and right tower arrays" do
      expect(game.middle_tower).to be_empty
      expect(game.right_tower).to be_empty
    end

    it "should initialize four pieces in the left tower array" do
      expect(game.left_tower.length).to eq(4)
    end

    it "left tower should have discs length in order of 4, 3, 2, 1" do
      expect(game.left_tower).to eq([4, 3, 2, 1])
    end

  end

  describe "#won?" do

    it "should return true if left & any other tower are both empty" do
      game.left_tower = []
      game.middle_tower = [4, 3, 2, 1]
      game.right_tower = []

      expect(game.won?).to be true

      game.middle_tower = []
      game.right_tower = [4, 3, 2, 1]
      expect(game.won?).to be true
    end

    it "should return false if left tower is not empty" do
      game.left_tower = [1]
      expect(game.won?).to be false
    end

    it "returns false if right and middle towers both aren't empty" do
      game.left_tower = []
      game.middle_tower = [4,3,2]
      game.right_tower = [1]
      expect(game.won?).to be false
    end
  end

  describe "#move" do

    it "should be able to move a piece to an empty tower" do
      game.move(["L", "M"])

      expect(game.left_tower).to eq([4, 3, 2])
      expect(game.middle_tower).to eq([1])
    end

    it "should be able to move a smaller piece to a larger piece" do
      game.move(["L", "M"])
      game.move(["L", "R"])
      game.move(["M", "R"])

      expect(game.left_tower).to eq([4, 3])
      expect(game.middle_tower).to eq([])
      expect(game.right_tower).to eq([2, 1])
    end

    it "shouldn't be able to move from an empty tower" do
      expect { game.move(["M", "R"]) }.to raise_error("No piece there!")
    end

    it "can't move a larger piece onto a smaller piece" do
      game.move(["L", "M"])

      expect { game.move(["L", "M"]) }.to raise_error("Piece selected too big.")
    end
  end

end

# In a loop, prompt the user (using gets) and ask what pile to select a disc from, and where to put it.

# After each move, check to see if they have succeeded in moving all the discs, to the final pile. If so, they win!

# #move
# Get a code review from a TA
