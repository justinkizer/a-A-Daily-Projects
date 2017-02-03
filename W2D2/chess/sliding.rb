module Sliding
VERTICAL = [[-1, 0], [1,0]]
HORIZONTAL = [[0,-1],[0,1]]
DIAGONAL = [[-1,-1],[-1,1],[1,1],[1,-1]]

  def move(direction)
    possible_moves = []
    pos = self.pos.dup
    offsets = direction
    offsets.each do |offset|
      next_move = move_once(offset,pos)
      while valid_move?(next_move)
        possible_moves << next_move
        next_move = move_once(offset,next_move)
      end
      if self.board.in_bounds?(next_move) && self.board[next_move].color != self.color
        possible_moves << next_move
      end

    end
    possible_moves
  end

  # def move_vertical(direction)
  #   possible_moves = []
  #   pos = self.pos.dup
  #   offsets = direction
  #   offsets.each do |offset|
  #     next_move = move(offset,pos)
  #     while valid_move?(next_move)
  #       possible_moves << next_move
  #       next_move = move(offset,next_move)
  #     end
  #     if self.board.in_bounds?(next_move) && self.board[next_move].color != self.color
  #       possible_moves << next_move
  #     end
  #
  #   end
  #   possible_moves
  # end
  #
  # def move_horizontal
  #   possible_moves = []
  #   pos = self.pos.dup
  #   offsets = [[0,-1],[0,1]]
  #   offsets.each do |offset|
  #     next_move = move(offset,pos)
  #     while valid_move?(next_move)
  #       possible_moves << next_move
  #       next_move = move(offset,next_move)
  #     end
  #     if self.board.in_bounds?(next_move) && self.board[next_move].color != self.color
  #       possible_moves << next_move
  #     end
  #
  #   end
  #   possible_moves
  # end
  #
  # def move_diagonal
  #   possible_moves = []
  #   pos = self.pos.dup
  #   offsets = [[-1,-1],[-1,1],[1,1],[1,-1]]
  #   offsets.each do |offset|
  #     next_move = move(offset,pos)
  #     while valid_move?(next_move)
  #       possible_moves << next_move
  #       next_move = move(offset,next_move)
  #     end
  #     if self.board.in_bounds?(next_move) && self.board[next_move].color != self.color
  #       possible_moves << next_move
  #     end
  #
  #   end
  #   possible_moves
  # end

  def move_once(offset, pos)
    temp_pos = []
    pos.each_index do |i|
      temp_pos << pos[i] + offset[i]
    end
    temp_pos
  end

  def valid_move?(pos)
    return true if self.board.in_bounds?(pos) && self.board[pos].is_a?(NullPiece)
    false
  end
end
