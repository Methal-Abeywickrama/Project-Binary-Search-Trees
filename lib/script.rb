# frozen_string_literal: true

require_relative 'merge_sort'
require_relative 'remove_duplicates'

# the node class
class Node
  include Comparable
  attr_accessor :left, :right, :val

  def initialize(val = nil, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end

  def <=>(other)
    @val <=> other
  end

  def inspect
    @val
  end

  def insert(value)
    if value > self.val
      if self.right.nil?
        self.right = Node.new(value)
      else
        self.right.insert(value)
      end
    elsif value < self.val
      if self.left.nil?
        self.left = Node.new(value)
      else
        self.left.insert(value)
      end
    end
  end

  
end

# the BST class
class Tree
  include MergeSort
  include RemoveDuplicates
  attr_accessor :root

  def initialize(array)
    @source = array
    @root = build_tree(@source)
  end

  def build_tree(array)
    p remove_duplicates(msort(array))
    create_tree(remove_duplicates(msort(array)))
  end

  def create_tree(array)
    return Node.new(array[0]) unless array.length > 1

    mid = array.length/2
    Node.new(array[mid], create_tree(array[0...mid]), create_tree(array[mid+1..-1]))
  end
end

arra = [3, 2, 5, 2, 3, 43, 7, 6, 23, 6, 98, 111, 77]
parra = [6, 2, 4]

tree = Tree.new(arra)
too = Tree.new(parra)

too.root.insert(8)
p tree.root
p tree.root.right
p tree.root.right.left.left
p tree.root.left
p 'ji'
p too.root.right.right
