class Fixnum

end

class Array
  def hash
    return 0 if self.flatten == []
    self.inject do |acc, el|
      (acc + el) ^ el
    end
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.inject(0) do |acc,(key, value)|
      acc^((key.to_s.ord + 1)^(value.ord))
    end
  end
end
