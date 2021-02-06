require 'pry'

class LinkedList
  attr_accessor :head, :tail
  def initialize
    @head = nil
    @tail = nil
  end

  def empty?
    @head == nil || @tail == nil
  end
  
  def size
    size = 0
    if self.empty?
      size
    else
      size = 1
      current_node = @head
      until current_node.next_node == nil
        size += 1
        current_node = current_node.next_node
      end
      size
    end
  end

  def at(index)
    if index.negative?
      nil
    elsif self.empty?
      nil
    elsif index + 1 > self.size
      nil
    elsif index + 1 == self.size
      @tail.value
    else      
      current_node = @head
      index.times do
        current_node = current_node.next_node
      end
    current_node.value
    end
  end

  def pop
    current_node = @head 
    current_node = current_node.next_node until current_node.next_node == @tail
    deleted_node = current_node.dup
    current_node.next_node = nil
    @tail == current_node
    deleted_node
  end

  def contains?(value)
    contains = false
    current_node = @head
    contains = true if current_node.value == value
    until current_node.next_node.nil?
      current_node = current_node.next_node
      contains = true if current_node.value == value
    end
    contains
  end

  def find(value)
    current_node = @head
    index = nil
    counter = 0
    index = counter if current_node.value == value
    until current_node.next_node.nil?
      current_node = current_node.next_node
      counter += 1
      index = counter if current_node.value == value
    end
    index
  end

  def to_s
    current_node = @head
    print "( #{current_node.value} ) -> "
    until current_node.next_node.nil?
      current_node = current_node.next_node
      print "( #{current_node.value} ) -> "
    end
    print 'nil'
  end
   
    
  def append(value)
    if self.empty?
      first_node = Node.new(value)
      @head = first_node
      @tail = first_node
    else
      #tail is last node in list, should point to the new node with value of value
      @tail = @tail.next_node = Node.new(value)
    end
  end
    
  def prepend(value)
    if self.empty?
      first_node = Node.new(value)
      @head = first_node
      @tail = first_node
    else
      # Value for next_node for the new first node is the current head node.
      # New head-node
      @head = Node.new(value, @head)
    end
  end

end

class Node
  attr_accessor :value, :next_node
  
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

end

list = LinkedList.new
list.append(1)
list.append(2)
list.append(3)
list.append('a')
list.append('b')

binding.pry