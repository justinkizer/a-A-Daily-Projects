require_relative "nullpiece"
require_relative "piece"
require_relative "king"
require_relative "queen"
require_relative "bishop"
require_relative "knight"
require_relative "rook"
require_relative "pawn"


require_relative "display"
require 'byebug'


class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance} }
    setup
  end

  def setup
    lay_out = [Rook.new(nil, self), Knight.new(nil, self),
      Bishop.new(nil, self), Queen.new(nil, self), King.new(nil, self),
      Bishop.new(nil, self), Knight.new(nil, self), Rook.new(nil, self)]
    @grid.each_with_index do |row, i|
      if i == 0
        row.each_index do |j|
          self[[i,j]] = lay_out[j]
          self[[i,j]].color = :red
        end
      elsif i == 1
        row.each_index do |j|
          self[[i,j]] = Pawn.new(:red, self)
        end
      elsif i == @grid.length-2
        row.each_index do |j|
          self[[i,j]] = Pawn.new(:black, self)
        end
      elsif i == @grid.length-1
        row.each_index do |j|
          self[[i,j]] = lay_out[j].dup
          self[[i,j]].color = :black
        end
      end
    end
    self[[7,3]],self[[7,4]] = self[[7,4]],self[[7,3]]
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end

  def move_piece(start_pos, end_pos)
  unless self[start_pos].is_a?(NullPiece) || !valid_move?(start_pos,end_pos,self[start_pos])
      raise "No piece there or invalid move"
    end

    current_piece = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos] = current_piece
  end

  def valid_move?(start_pos, end_pos, piece)
    return false unless in_bounds?(start_pos, end_pos)
    return false if piece.color == self[end_pos].color
    return false unless legal_move?(start_pos, end_pos, piece)
    true
  end

  def legal_move?(start_pos, end_pos, piece)
    offsets = piece.moves

    offsets.each_with_index do |pair, i|
      pair.map.with_index do |coord, j|
        offsets[i][j] += start_pos[j]
      end
    end

    offsets.include?(end_pos)
  end

  def in_bounds?(start_pos, end_pos=[])
    (start_pos + end_pos).flatten.all? { |coord| coord.between?(0, @grid.length - 1) }
  end
end

if __FILE__ == $PROGRAM_NAME
  a = Board.new
  b = Display.new(a)
  while true
    b.display
  end
end
