require_relative "nullpiece"
require_relative "piece"
require 'byebug'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.new} }

  end

  def setup
    @grid.each_with_index do |row, i|
      if [0,1].include?(i)
        row.each_index do |j|
          @grid[i][j] = Piece.new(:white)
        end
      elsif [@grid.length-1, @grid.length-2].include?(i)
        row.each_index do |j|
          @grid[i][j] = Piece.new(:black)
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    row, col = start_pos
    if @grid[row][col].is_a?(NullPiece) || !valid_move?(start_pos,end_pos,@grid[row][col])
      raise "No piece there"
    end

    current_piece = @grid[row][col]
    @grid[row][col] = NullPiece.new
    row, col = end_pos
    @grid[row][col] = current_piece
  end

  def valid_move?(start_pos, end_pos, piece)
    return false unless in_bounds?(start_pos, end_pos)
    row, col = end_pos
    return false if piece.color == @grid[row][col].color
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
    (start_pos + end_pos).flatten.none? { |coord| coord > @grid.length }
  end
end
