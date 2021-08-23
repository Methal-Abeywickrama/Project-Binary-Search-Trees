# frozen_string_literal: true

require_relative 'merge_sort'

# the node class
class Node
  include Comparable

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
end

# the BST class
class Tree
  include MergeSort
  attr_accessor :root

  def initialize (array)
    @source = array
    @root = build_tree(@source)
  end

  def build_tree(array)
    sorted_array = msort(array)
    sorted_array
  end

end

arra = [2, 5, 2, 43, 7, 23, 6, 98]

tree = Tree.new(arra)

p tree.root