class MaxIntSet
  attr_reader :max
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    if num > max || num < 0
      raise "Out of bounds"
    else
      @store[num] = true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private
  
  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :num_buckets
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    i = num % num_buckets
    @store[i] << num
  end

  def remove(num)
    if self.include?(num)
      i = num % num_buckets
      @store[i].delete(num)
    end
  end

  def include?(num)
    i = num % num_buckets
    @store[i].include?(num)
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end
require "byebug"
class ResizingIntSet
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    i = num % num_buckets
    unless @store[i].include?(num) 
      @count += 1
      @store[i] << num
      if self.count > num_buckets
        resize!
      end
      
    end
  end

  def remove(num)
    if self.include?(num)
      i = num % num_buckets
      @store[i].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    i = num % num_buckets
    @store[i].include?(num)
  end

  # def count
  #   counter = 0
  #   @store.each do |bucket|
  #     counter += bucket.length
  #   end
  #   @count = counter
  #   counter
  # end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    #making twice as many buckets
    @count = 0
    new_num_buckets = num_buckets * 2
    num_buckets.times do 
      @store << []
    end
    num_buckets = new_num_buckets

    #putting elements into NEW buckets
    temp = @store
    @store = Array.new(num_buckets) { Array.new }
      temp.each do |bucket|
        bucket.each do |num|
        #remove from the original bucket, and store in a temp array
        insert(num)
      end
    end

  end
end


# test = ResizingIntSet.new
# 3.times { test.insert(1) }