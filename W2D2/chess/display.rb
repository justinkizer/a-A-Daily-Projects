require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def display
    render
    @cursor.get_input
  end


  def render
    system("clear")
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |el, j|
        if [i, j] == @cursor.cursor_pos
          print el.to_s.colorize(:green)
        else
          print el.to_s.colorize(el.color)
        end
      end
      puts "\n"
    end
  end

end
#
# puts "Q".colorize(:blue)
# puts "_".colorize(:green)
