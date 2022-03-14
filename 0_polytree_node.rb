class PolyTreeNode
    def initialize(value)
        @parent = nil
        @value = value
        @children = []
    end

    attr_reader :parent, :children, :value

    def parent=(parent_node)
        @parent.children.delete(self) unless @parent.nil?
        @parent = parent_node
        @parent.children << self unless parent_node.nil?
        self.parent
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Node is not a child" if child_node.parent.nil?
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            focus = queue.shift
            return focus if focus.value == target_value
            focus.children.each { |child| queue << child }
        end
        nil
    end
end