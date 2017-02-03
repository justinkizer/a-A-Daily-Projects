# require_relative 'sliding'
# require_relative 'stepping'

class Piece
  # include Sliding
  # include Stepping

  attr_reader :board
  attr_accessor :pos, :color

  def initialize(color, board)
    @color = color
    # @type = type
    @symbol = "P"
    @board = board
    # @pos = pos

  end

  def to_s
    @symbol
  end

  def pos
    row_idx = nil
    @board.grid.each_with_index {|row, i| row_idx = i if row.include?(self)}
    col_idx = @board.grid[row_idx].index(self)
    [row_idx, col_idx]
  end

end
