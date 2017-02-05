class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  attr_reader :head
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    get = nil
    start = @head
    until start.next.nil?
      if start.key == key
        get = start.val
      end
      start = start.next
    end
    get
  end

  def include?(key)
    start = @head
    until start.next.nil?
      return true if start.key == key
      start = start.next
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key,val)
    @tail.prev.next = new_link
    new_link.prev = @tail.prev
    @tail.prev = new_link
    new_link.next = @tail
  end

  def update(key, val)
    start = @head
    until start.next.nil?
      if start.key == key
        start.val = val
      end
      start = start.next
    end
  end

  def remove(key)
    start = @head
    until start.next.nil?
      if start.key == key
        start.remove
      end
      start = start.next
    end
  end

  def each
    start = @head.next
    until start.next.nil?
      yield(start)
      start = start.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
