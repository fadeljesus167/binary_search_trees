class Node
  attr_accessor :value, :left_child, :right_child

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end

  def has_childs?
    @left_child || @right_child
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
      break if new_node.value.eql?(node.value)
      if new_node.value < node.value
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
    # Case 1: Deleting a leaf node
    node = @root

    if @root.value.eql?(value)
      puts "Can't delete root node"
      return
    end

    while !node.nil?
      if node.value > value
        if node.left_child.nil?
          puts "Value not found"
          break
        else
          if node.left_child.value.eql?(value)
            if node.left_child.has_childs?
              temp_node = node.left_child
              if !temp_node.right_child.nil?
                node.left_child = temp_node.right_child
              else
                node.left_child = temp_node.left_child
              end
            else
              node.left_child = nil
            end
            break
          else
            node = node.left_child
          end
        end
      else
        if node.right_child.nil?
          puts "Value not found"
          break
        else
          if node.right_child.value.eql?(value)
            if node.right_child.has_childs?
              temp_node = node.right_child
              if !temp_node.right_child.nil?
                node.right_child = temp_node.right_child
              else
                node.right_child = temp_node.left_child
              end
            else
              node.right_child = nil?
            end
            break
          else
            node = node.right_child
          end
        end
      end
    end
  end
end

def successor(node)
  node = node.right_child

  while !node.nil? && node.left_child.nil?
    node = node.left_child
  end
end

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
end

def menu(tree)
  while true
    print "\tBinary Search Tree\n1 - Insert\n2 - Delete\n3 - Exit\nOpc: "
    opc = gets.chomp.to_i

    case opc
    when 1
      puts "Write a number to insert: "
      tree.insert(Node.new(gets.chomp.to_i))
    when 2
      puts "Write a number to delete: "
      tree.delete(gets.chomp.to_i)
    when 3
      break
    end

    pretty_print(tree.root)
  end
end

tree = Tree.new([1,2,3,4,5,6,7,8,9])
menu(tree)