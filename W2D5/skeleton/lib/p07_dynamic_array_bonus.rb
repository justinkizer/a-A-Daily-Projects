class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)
    i = 0
    until @store[i].nil?
      i += 1
    end
    @store[i] = val
    @count += 1
  end

  def unshift(val)

  end

  def pop
    i = @store.length - 1
    until !@store[i].nil? || i == 0
      i -= 1
    end
    return nil if @count == 0
    element = @store[i]
    @store[i] = nil
    @count -= 1
    element
  end

  def shift

  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each

  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  end
end
