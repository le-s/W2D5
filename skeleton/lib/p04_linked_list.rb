require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
    #byebug
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    search_next = @head.next
    until search_next.key == key
      search_next = search_next.next
      if search_next == @tail
        return nil
      end
    end
    search_next.val
  end

  def include?(key)
    search_next = @head.next
    until search_next == @tail
      if search_next.key == key
        return true
      else
        search_next = search_next.next
      end
    end

    false
  end

  def append(key, val)
    last_node = @tail.prev
    add_node = Node.new(key, val)
    last_node.next = add_node
    add_node.prev = last_node
    add_node.next = @tail
    @tail.prev = add_node
  end

  def update(key, val)
    # debugger
    search_next = @head.next
    if search_next == @tail
      return nil
    end

    until search_next.key == key
      search_next = search_next.next
      if search_next == @tail
        return nil
      end
    end

    search_next.val = val
    search_next.val
  end

  def remove(key)
    search_next = @head.next
    until search_next.key == key
      search_next = search_next.next
      if search_next == @tail
        return nil
      end
    end

    node_to_remove = search_next
    node_to_remove.prev.next = node_to_remove.next
    node_to_remove.next.prev = node_to_remove.prev

  end

  def each
    result = []
    search_next = @head.next

    until search_next == @tail
      #byebug
      yield(search_next)
      search_next = search_next.next
    end
    result
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
