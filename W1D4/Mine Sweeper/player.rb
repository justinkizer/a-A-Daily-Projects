class Player

  def initialize(name=" ")
    @name = name
  end

  def get_input(string)
    puts "Please input move and position (e.g. f 3,1)"
    choice = string[0]
    position = string[1..-1].split(",").map(&:to_i)
    [choice, position]
  end

end
