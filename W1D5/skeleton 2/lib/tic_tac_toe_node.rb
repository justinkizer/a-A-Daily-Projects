require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)

  end

  # def [](pos)
  #   row, col = pos
  #   @board[row][col]
  # end
  #
  # def []=(pos, value)
  #   row, col = pos
  #   @board[row][col] = value
  # end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    potential_game_states = []
    switch_mover_marks
    @board.rows.length.times do |row|
      @board.rows.length.times do |col|
        new_board = @board.dup
        if new_board[[row, col]].nil?
          new_board[[row, col]] = next_mover_mark
          potential_game_states << TicTacToeNode.new(new_board, next_mover_mark, [row,col])
        end
      end
    end
    potential_game_states
  end

  def switch_mover_marks
    @next_mover_mark = (@next_mover_mark == :x ? :o : :x)
  end

  def losing_node?(mover_mark)
    if board.over? && winner == mover_mark
      #true/false
    elsif board.over? && winner != mover_mark || winner.nil?
      #false/true
    end
  end

  def winning_node?(mover_mark)

  end

end
