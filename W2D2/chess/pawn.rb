require_relative 'piece'

class Pawn < Piece
  def initialize(color,board)
    super
    @symbol = "P"
  end

end
