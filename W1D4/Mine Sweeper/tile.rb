class Tile
  attr_accessor :bomb, :flagged, :revealed, :bounds
  attr_reader :pos

  def initialize
    @bomb, @flagged, @revealed = false, false, false
    @pos = nil
  end

  def reveal
    @revealed = true
  end

  def toggle_flag
    !@flagged
  end

  def neighbors
    adjacent_tiles = []
    x, y = @pos
    [-1, 0, 1].each do |i|
      [-1, 0, 1].each do |j|
        adjacent_tiles << [(x + i), (y + j)] unless i == 0 && j == 0
      end
    end
    adjacent_tiles.select { |pos| pos.all? { |x| x.between?(0, @bounds.length-1)} }
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |neighbor|
      count += 1 if neighbor.bomb
    end
    count
  end

end
