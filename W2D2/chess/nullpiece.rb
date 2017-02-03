require_relative "piece"
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def color
    :purple
  end

  def to_s
    "_"
  end

end
