require_relative 'Board.rb'

class Game
  DECK = 4
  def initialize(board = Board.new)
    @board = board
  end

  def play
    @board.populate
    open_card = 0
    memory_pos = []
    until game_over?
      @board.render
      pos = request_guess
      make_guess(pos)
      memory_pos << pos
      open_card += 1
      open_card = hide_card(memory_pos) if open_card == 2
      system("clear")
    end
  end

  def hide_card(memory_pos)
    @board.render
    sleep(2)
    unless match?(memory_pos)
      @board[memory_pos[0]].hide
      @board[memory_pos[1]].hide
    end
    2.times {memory_pos.pop}
    0
  end

  def match?(memory_pos)
    @board[memory_pos[0]].value == @board[memory_pos[1]].value
  end

  def make_guess(pos)
    @board.reveal(pos)
  end

  def game_over?
    @board.grid.flatten.all? { |card| card.face_position}
  end

  def request_guess
    input = true
    while input
      print "enter position(x, y): "
      pos = gets.chomp.split(',').map(&:to_i)
      return pos if pos[0] < DECK && pos[0] < DECK
    end
  end

end

if $0 == __FILE__
  Game.new.play
end
