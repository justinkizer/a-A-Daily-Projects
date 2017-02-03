require_relative 'piece'
require_relative 'sliding'

class Queen < Piece
  include Sliding
  def initialize(color,board)
    super
    @symbol = "Q"
  end

  def moves
    move(VERTICAL) + move(HORIZONTAL) + move(DIAGONAL)
  end
end
