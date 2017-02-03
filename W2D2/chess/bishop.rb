require_relative 'piece'
require_relative 'sliding'

class Bishop < Piece
  include Sliding
  def initialize(color,board)
    super
    @symbol = "B"
  end

  def moves
    move(DIAGONAL)
  end
end
