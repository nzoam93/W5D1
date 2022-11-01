class HashSet
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    i = key.hash % num_buckets
    unless @store[i].include?(key) 
      @count += 1
      @store[i] << key
      if self.count > num_buckets
        resize!
      end
      
    end

  end

  def include?(key)
    i = key.hash % num_buckets
    @store[i].include?(key)
  end

  def remove(key)
    if self.include?(key)
      i = key.hash % num_buckets
      @store[i].delete(key)
      @count -= 1
    end
  end

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
