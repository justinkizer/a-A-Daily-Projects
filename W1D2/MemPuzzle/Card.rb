class Card
  attr_reader :value, :face_position

  def initialize(value)
    @face_position = false
    @value = value
  end

  def hide
    @face_position = false
  end

  def reveal
    @face_position = true
  end

  def to_s
    display = 'close'
    display = @value if @face_position
    print display
  end

  def ==(card)
    return false unless card.is_a?(Card)
    self.value == card.value
  end

end
