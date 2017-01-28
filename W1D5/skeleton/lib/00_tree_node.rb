class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.reject! { |child| child == self } if @parent
    @parent = node
    @parent.children << self if @parent && !@parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
    @children << child_node unless @children.include?(child_node)
  end

  def remove_child(child_node)
    raise unless @children.include?(child_node)
    child_node.parent = nil
    @children.delete(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value

    @children.each do |child|
      target_node = child.dfs(target_value)
      return target_node if target_node
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end

    nil
  end

end
