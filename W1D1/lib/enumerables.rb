class Array
  def my_each(&prc)
    idx = 0

    while idx < length
      prc.call(self[idx])
      idx += 1
    end
    self
  end

  def my_select(&prc)
    output = []
    idx = 0
    while idx < length
      output << self[idx] if prc.call(self[idx])
      idx += 1
    end
    output
  end
  def my_reject(&prc)
    output = []
    idx = 0
    while idx < length
      output << self[idx] unless prc.call(self[idx])
      idx += 1
    end
    output
  end

  def my_any?(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |el|
      return false if !prc.call(el)
    end
    true
  end

  def my_flatten
    output = []
    self.each do |x|
      if x.class != Array
        output << x
      else
        output += x.flatten
      end
    end
    output
  end

  def my_zip(*args)
    output = []
    (self.length).times do |idx|
      little_array = []
      little_array << self[idx]
      i = 0
      while i < args.length
        little_array << args[i][idx]
        i += 1
      end
      output << little_array
    end
    output
  end

  def my_rotate(num = 1)
    output = self.dup
    num.abs.times do |idx|
      if num > 0
        output.push(output.shift)
      else
        output.unshift(output.pop)
      end
    end
    output
  end

  def my_join(seperator = "")
    output = ""
    self.each_with_index do |x, idx|
      unless idx == length - 1
        output << x + seperator
      else
        output << x
      end
    end

    output
  end

  def my_reverse
    (self.length / 2).times do |x|
      self[x],self[-x - 1] = self[-x - 1],self[x]
    end
  end

end
puts "**output from my each"
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

p return_value

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]


a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]


a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
