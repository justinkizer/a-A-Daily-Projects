class EightQueens


  def initialize(n = 8)
    @num_queens = n
    @grid = []
    for i in 0...@num_queens do
      row = []
      for j in 0...@num_queens do
        row << :X
      end
      @grid << row
    end
  end

  def solve
    populate_random
    p get_conflicts
    render
    # until solved?
    # end
    # while (not solved)
    # display the board
    # if not - count the number of conflicts per queen. choose the queen
    #   with the most conflicts.
    # look at all the possible positions for that queen along that row.
    # calculate the potential conflicts at each of those positions.
    # move to the one with the least conflicts.

    # we're done

  end

  def populate_random
    @queen_positions = []
    @grid.each do |row|
      @queen_positions << rand(@num_queens)
      row[@queen_positions.last] = :Q
    end
    p @queen_positions
  end

  def solved?
    get_conflicts == 0
  end

  def get_conflicts # number of conflicts, per queen/row
    # same column conflicts
    conflicts = []
    @queen_positions.each do |queen_column|
      col_conflicts = @queen_positions.count do |other_queen_column|
        queen_column == other_queen_column
      end
      col_conflicts -= 1
    end

    # same diagonal conflicts

    conflicts
  end

  def move_queen(row, from_col, to_col)

  end

  def render
    string = "\n"
    for i in 0...@num_queens do
      row = ""
      for j in 0...@num_queens do
        row << @grid[i][j].to_s
        row << " "
      end
      row << "\n"
      string << row
    end
    puts string
  end

end
