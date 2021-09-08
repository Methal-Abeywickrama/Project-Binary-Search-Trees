# frozen_string_literal: true

require_relative 'merge_sort'
require_relative 'remove_duplicates'
require 'pry-byebug'

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

  def insert_at(value)
    if value > self.val
      if self.right.nil?
        self.right = Node.new(value)
      else
        self.right.insert_at(value)
      end
    elsif value < self.val
      if self.left.nil?
        self.left = Node.new(value)
      else
        self.left.insert_at(value)
      end
    end
  end

  def inorder_loop(root = self, ordered = [])
    return ordered if root.nil?
    return ordered if root.val.nil?

    inorder_loop(root.left, ordered)
    ordered.push(root.val)
    inorder_loop(root.right, ordered)
  end

  def postorder_loop(root = self, ordered = [])
    return ordered if root.nil?
    return ordered if root.val.nil?

    postorder_loop(root.left, ordered)
    postorder_loop(root.right, ordered)
    ordered.push(root.val)
  end

  def preorder_loop(root = self, ordered = [])
    return ordered if root.nil?
    return ordered if root.val.nil?

    ordered.push(root.val)
    preorder_loop(root.left, ordered)
    preorder_loop(root.right, ordered)
  end

  def delete(value)
    if value == self.val
      if self.left.val.nil? && self.right.val.nil?
        self.val = nil
        return
      elsif self.right.nil?
        self.left = self.left.left
        self.right = self.left.right
        self.val = self.left.val
        return
      elsif self.left.nil?
        self.right = self.right.right
        self.left = self.right.left
        self.val = self.right.val
        return
      elsif self.right.left.nil?
        self.val = self.right.val
        self.right =self.right.right
      else
        self.val = find_successor(self.right)
      end

    elsif value > self.val
      return if self.right.nil?

      delete(value) if value == self.val
      self.right.delete(value)

    else
      return if self.right.nil?

      delete(value) if value == self.val
      self.left.delte(value)
    end
  end

  def find_successor(input)
    return input if input.left.nil?

    find_successor(input.left)
  end

  def find_node(value)
    return value if self.val == value

    return nil if self.val.nil?

    if value > self.val
      find_node(self.right)
    else
      find_node(self.left)
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

  def insert(val)
    @root.insert_at(val)
  end

  def build_tree(array)
    create_tree(remove_duplicates(msort(array)))
  end

  def create_tree(array)
    return nil if array.empty?
    return Node.new(array[0]) unless array.length > 1

    mid = array.length/2
    Node.new(array[mid], create_tree(array[0...mid]), create_tree(array[mid+1..-1]))
  end

  def inorder
    @root.inorder_loop
  end

  def postorder
    @root.postorder_loop
  end

  def preorder
    @root.preorder_loop
  end

  def find(value)
    find_node(value)
  end

  def level_order
    return if @root.nil?

    order = []
    queue = []
    queue.push(@root)

    while !queue.empty?
      current = queue[0]
      order.push(current.val)
      queue.shift

      unless current.left.nil?
        unless current.left.val.nil?
          queue.push(current.left)
        end
      end
      unless current.right.nil?
        unless current.right.val.nil?
          queue.push(current.right)
        end
      end
    end
    order
  end

  def height(node, level = 0)
    return 0 if node.nil?
    return level if node.left.nil? && node.right.nil?
    return level + 1 if node.left.nil? || node.right.nil?

    # level += 1
    left = height(node.left, level + 1)
    right = height(node.right, level + 1)
    left > right ? left : right
  end

  def depth(target, level = 0, node = @root)
    return nil if node.nil?
    return level if node.val == target

    if target > node.val
      depth(target, level + 1, node.right)
    elsif target < node.val
      depth(target, level + 1, node.left)
    else
      return nil
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    difference = (right_height - left_height)
    binding.pry
    return true if difference.abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance
    data = tree.inorder
    @root = self.build_tree(data)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.val}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

arra = (Array.new(15) { rand(1..100) })

tree = Tree.new(arra)

p tree.balanced?
tree.pretty_print

p tree.inorder
p tree.preorder
p tree.postorder

tree.insert(111)
tree.insert(112)
tree.insert(113)
tree.insert(114)
tree.insert(115)
tree.insert(116)
tree.pretty_print
binding.pry
p tree.balanced?
