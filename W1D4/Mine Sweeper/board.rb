require_relative "tile"

class Board
  attr_reader :grid
  def initialize(size = 10)
    @grid = Array.new(size) { Array.new(size) { Tile.new } }
  end

  def find_pos(tile)
    pos = []
    @grid.each_with_index do |row, i|
      if row.include?(tile)
        pos << i
        pos << row.index(tile)
      end
    end
    pos
  end

  def populate
    bomb_num = size / 5
    bomb_num.times do |i|
      pos = [rand(0...@grid.length), rand(0...@grid.length)]
      while self[pos].bomb
        pos = [rand(0...@grid.length), rand(0...@grid.length)]
      end
      self[pos].bomb = true
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

F for Flag
* for Unexplored
_ for Open
Digits for Bomb numbes

  def render
    @grid
  end

end

a = Board.new
p a.grid[0][0].bomb = true
p a.grid[0][0]
p a.grid[0][1]
p a.grid

for each row, does the row include el == tile.object
row.index(tile object)
