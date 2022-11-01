class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each.with_index do |ele, index|
      sum *= ele.ord.hash if index.odd?
      sum -= ele.ord.hash if index.even?
    end
    sum
  end
end

class String
  def hash
    sum = 0
    arr = self.split("")
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.each do |key, val|
      sum -= key.to_s.to_i.hash 
    end
    sum
  end
end

