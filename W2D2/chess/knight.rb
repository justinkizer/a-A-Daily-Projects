require_relative 'piece'
require_relative 'stepping'

class Knight < Piece
  include Stepping
  def initialize(color,board)
    super
    @symbol = "N"
  end

end
