class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    bucket_index = key.hash % @store.length
    unless @store[bucket_index].include?(key)
      @store[bucket_index] << key
      @count += 1
      if @count >= @store.length
        resize!
      end
      return true
    end
    false
  end

  def include?(key)
    bucket_index = key.hash % @store.length
    @store[bucket_index].include?(key)
  end

  def remove(key)
    bucket_index = key.hash % @store.length
    if @store[bucket_index].include?(key)
      @store[bucket_index].delete(key)
      @count -= 1
      return true
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    result = Array.new(@store.length * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        insert_index = num % result.length
        result[insert_index] << num unless result[insert_index].include?(num)
      end
    end
    @store = result
  end
end
