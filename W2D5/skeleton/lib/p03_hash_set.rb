require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(element_buckets = 8)
    @store = Array.new(element_buckets) { Array.new }
    @element_buckets = element_buckets
    @count = 0
  end

  def insert(element)
    self[element.hash] << element
    @count += 1
    resize! if @count > @element_buckets
  end

  def remove(element)
    self[element.hash].delete(element)
  end

  def include?(element)
    self[element.hash].include?(element)
  end

  private

  def [](element)
    @store[element % @element_buckets]
  end

  def element_buckets
    @store.length
  end

  def resize!
    store_dup = @store.flatten
    @element_buckets *= 2
    @store = Array.new(@element_buckets) { Array.new }
    @count = 0
    store_dup.each do |el|
      self.insert(el)
    end
  end
end
