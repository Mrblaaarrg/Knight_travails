module Searchable
    def dfs(target = nil, &prc)
        raise "Need a proc or target" if [target, prc].none?
        prc ||= Proc.new { |node| node.value == target }

        return self if prc.call(self)

        self.children.each do |child|
            result = child.dfs(&prc)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target = nil, &prc)
        raise "Need a proc or target" if [target, prc].none?
        prc ||= Proc.new { |node| node.value == target }
        queue = [self]
        until queue.empty?
            focus = queue.shift
            return focus if prc.call(focus)
            queue.concat(focus.children)
        end
        nil
    end

    def count
        1 + children.map(&:count).inject(:+)
    end
end

class PolyTreeNode
    include Searchable
    def initialize(value)
        @parent = nil
        @value = value
        @children = []
    end

    attr_accessor :value
    attr_reader :parent

    def children
        @children.dup
    end

    def parent=(parent_node)
        @parent.children_.delete(self) unless @parent.nil?
        @parent = parent_node
        @parent.children_ << self unless parent_node.nil?
        self.parent
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Node is not a child" if child_node.parent != self
        child_node.parent = nil
    end

    protected
    
    def children_
        @children
    end
end