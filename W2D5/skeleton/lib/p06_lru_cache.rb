require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      result = @map.get(key)
      @store.remove(key)
      @store.append(key, result)
    else
      result = @prc.call(key)
      @map.set(key, result)
      @store.append(key, result)
      eject! if @map.count > @max
      result
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    key = @store.head.next.key
    @store.remove(key)
    @map.delete(key)
  end
end
