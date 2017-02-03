module Stepping

KING_MOVES = [[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,-1],[-1,1],[1,1]]
KNIGHT_MOVES = [[-2,1],[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1]]

  def moves
    possible_moves = []
    pos = self.pos.dup
    offsets = (self.is_a?(King) ? KING_MOVES : KNIGHT_MOVES)
    offsets.each do |offset|
      next_move = move(offset,pos)
      possible_moves << next_move if valid_move?(next_move)
    end
    possible_moves
  end

  def move(offset, pos)
    temp_pos = []
    pos.each_index do |i|
      temp_pos << pos[i] + offset[i]
    end
    temp_pos
  end

  def valid_move?(pos)
    return true if self.board.in_bounds?(pos) && self.board[pos].color != self.color
    false
  end
end
