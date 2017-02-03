require_relative 'piece'
require_relative 'sliding'

class Rook < Piece
  include Sliding
  def initialize(color,board)
    super
    @symbol = "R"
  end

  def moves
    move(VERTICAL) + move(HORIZONTAL)
  end
end
