require_relative "00_tree_node.rb"
require "byebug"
class KnightPathFinder
  MOVE_REACH = [
    [1, 2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-1, -2],
    [-2, -1]
  ]

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @bfs_queue = [PolyTreeNode.new([0,0])]
  end

  def build_move_tree
    move_tree = [@start_pos]
    move_tree.each do |pos|
      future_moves = KnightPathFinder.valid_moves(pos)
      new_move_positions(future_moves)
      future_moves.each do |valid_pos|
        move_tree << valid_pos
        @visited_positions << valid_pos
        parent_node = find_parent(pos)
        @bfs_queue << generate_nodes(valid_pos, parent_node)
      end

    end
    move_tree
  end

  def self.valid_moves(pos)
    valid_moves = []
    MOVE_REACH.each do |coord|
      adjusted_coord = [pos[0] + coord[0], pos[1] + coord[1]]
      valid_moves << adjusted_coord if KnightPathFinder.valid_pos?(adjusted_coord)
    end
    valid_moves
  end

  def new_move_positions(future_moves)
    future_moves.reject! { |duplicate_pos| @visited_positions.include?(duplicate_pos) }
  end

  def self.valid_pos?(pos)
    pos.first.between?(0, 7) && pos.last.between?(0, 7)
  end

  def find_path(end_pos)
    trace_path_back(get_target_node(end_pos))
  end

  def get_target_node(end_pos)
    @bfs_queue[0].bfs(end_pos)
  end

  def generate_nodes(pos, parent)
    new_node = PolyTreeNode.new(pos)
    new_node.parent = parent
    new_node
  end

  def find_parent(pos)
    @bfs_queue.select { |nodes| nodes.value == pos }[0]
  end

  def trace_path_back(node)
    return [node.value] if node.parent.nil?
    trace_path_back(node.parent) + [node.value]
  end

end

if __FILE__ == $PROGRAM_NAME
  a = KnightPathFinder.new([0,0])
  a.build_move_tree
  b = a.find_path([7,6])
  p b
end
