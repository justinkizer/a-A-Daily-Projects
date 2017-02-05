class MaxIntSet

  def initialize(max)
    @max = max
    @store = Array.new(max + 1)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    self[num] << num
    @count += 1
    resize! if @count > @num_buckets
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_dup = @store.flatten
    @num_buckets *= 2
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
    store_dup.each do |el|
      self.insert(el)
    end
  end
end
