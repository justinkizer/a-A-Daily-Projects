class Piece

  def initialize(color, type)
    @color = color
    @type = type
  end



  def to_s
    @symbol
  end

  private

  def self.Knight(color)
    Knight.new(color)
  end

end
