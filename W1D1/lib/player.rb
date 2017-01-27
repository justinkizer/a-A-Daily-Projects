class Player
  def initialize(name)
    @name = name

  end

  def guess
    puts "#{@name}, what's your move?"
    string = gets.chomp
  end
  def alert_invalid_guess
    puts "Invalid! Try again."
  end
  
end
