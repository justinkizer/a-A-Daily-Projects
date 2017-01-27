require_relative 'Card.rb'
class Board
  DECK = 4
  ALPHABET = ("a".."z").to_a
  attr_accessor :grid

  def initialize(grid = Array.new(DECK) { Array.new(DECK)})
    @grid = grid
  end

  def populate
    (DECK*2).times { add_pair }
  end

  def render
    DECK.times do |row|
      DECK.times do |col|
        @grid[row][col].to_s
        print "\t" unless col == DECK
      end
      puts unless row == DECK
    end
    return
  end

  def won?
    @grid.flatten.all? {|card| card.face_position}
  end

  def reveal(pos)
    self[pos].reveal
  end

  def hide(pos)
    self[pos].hide
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,value)
    x,y = pos
    @grid[x][y] = value
  end

  def add_pair
    placement = 0
    value = getvalue
    while placement < 2
      row, col = rand(DECK), rand(DECK)
      if @grid[row][col] == nil
        @grid[row][col] = Card.new(value)
        placement += 1
      end
    end

  end

  def getvalue
    check_value = true
    while check_value
      value = ALPHABET.sample
      check_value = value?(value)
    end
    value
  end

  def value?(value)
    #@grid.flatten.include?(value)
    DECK.times do |row|
      DECK.times do |col|
        if @grid[row][col].class == Card
          return true if @grid[row][col].value == value
        end
      end
    end
    false
  end

end
