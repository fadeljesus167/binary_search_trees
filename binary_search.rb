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
    return nil if data_array.empty?

    mid = data_array.length/2
    node = Node.new(data_array[mid])

    node.left_child = build_tree(data_array[0...mid])
    node.right_child = build_tree(data_array[mid+1..-1])
  
    return node
  end

  def insert(new_node)
    node = @root
    while !node.nil?
      if new_node.value <= node.value
        if node.left_child.nil?
          node.left_child = new_node
          break
        else
          node = node.left_child
        end
      else
        if node.right_child.nil?
          node.right_child = new_node
          break
        else
          node = node.right_child
        end
      end
    end
  end

  def delete(value)
    
  end
end

tree = Tree.new([1,2,3,4,5,6,7,8,9])

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
end

pretty_print(tree.root)

tree.insert(Node.new(-1))

pretty_print(tree.root)
