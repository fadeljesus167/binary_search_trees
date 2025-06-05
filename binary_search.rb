class Node
  attr_accessor :value, :left_child, :right_child

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end
end

class Tree
  attr_accessor :data, :root

  def initialize(data)
    @data = data
    @root = build_tree(data)
  end

  def build_tree(data_array)
    start = 0
    finale = data_array.length - 1
    mid = (start + finale)/2

    node = Node.new(data_array[mid])

    if data_array.length.eql?(1)
      return node
    else
      node.left_child = build_tree(data_array[start..mid-1])
      node.right_child = build_tree(data_array[mid+1..finale])
    end
  
    return node
  end
end

tree = Tree.new([1,2,3,4,5,6,7,8,9])

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
end

pretty_print(tree.root)
