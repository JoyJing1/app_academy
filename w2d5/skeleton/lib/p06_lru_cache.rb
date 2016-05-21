require 'byebug'
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :store, :map

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
    if @map.include?(calc!(key))
      link = @map[calc!(key)]
      update_link!(link)
      link.val
    else
      eject! if count >= @max
      val = @prc.call(key)

      new_link = Link.new(key, val)
      @map[calc!(key)] = new_link

      last_link = @store.last
      tail = last_link.next

      last_link.next = new_link
      tail.prev = new_link

      new_link.next = tail
      new_link.prev = last_link

      new_link.val

    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    key.hash
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    prev_link = link.prev
    next_link = link.next
    last_link = @store.last
    tail = last_link.next

    prev_link.next = next_link
    next_link.prev = prev_link

    last_link.next = link
    link.prev = last_link

    tail.prev = link
    link.next = tail
  end

  def eject!
    first_link = @store.first
    head = first_link.prev
    second_link = first_link.next

    head.next = second_link
    second_link.prev = head

    @map.delete(first_link.key)

  end
end
