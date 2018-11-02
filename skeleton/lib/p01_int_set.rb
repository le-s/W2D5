class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {[]}
  end

  def insert(num)
    raise "Out of bounds" if num > @store.length || num < 0
    @store[num] = [true]
  end

  def remove(num)
    @store[num] = [false]
  end

  def include?(num)
    @store[num] == [true]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    insert_index = num % @store.length
    @store[insert_index] << num
  end

  def remove(num)
    insert_index = num % @store.length
    @store[insert_index].delete(num)
  end

  def include?(num)
    insert_index = num % @store.length
    @store[insert_index].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    insert_index = num % @store.length
    unless @store[insert_index].include?(num)
      @store[insert_index] << num
      @count += 1
    end
    if @count > @store.length
      resize!
    end
  end

  def remove(num)
    insert_index = num % @store.length
    if @store[insert_index].include?(num)
      @store[insert_index].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    insert_index = num % @store.length
    @store[insert_index].include?(num)
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
