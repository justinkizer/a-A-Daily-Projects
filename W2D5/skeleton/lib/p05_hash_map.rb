require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
      resize! if @count > @num_buckets
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    i = 0
    while i < @store.length
      @store[i].each do |link|
        yield(link.key, link.val)
      end
      i += 1
    end
    self
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    store_dup = @store.dup
    @num_buckets *= 2
    @store = Array.new(@num_buckets) { LinkedList.new }
    @count = 0
    store_dup.each do |linked_list|
      linked_list.each do |link|
        self.set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % @num_buckets]
  end
end
