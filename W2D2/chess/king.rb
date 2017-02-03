require_relative 'piece'
require_relative 'stepping'

class King < Piece
  include Stepping
  def initialize(color,board)
    super
    @symbol = "K"
  end

end
