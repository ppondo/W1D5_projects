class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if self.parent != nil
            old_parent = self.parent
            old_childrens_arr = old_parent.children
            old_childrens_arr.delete(self)
        end

        @parent = node

        if node != nil
            node.children << self
        end
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        child.parent = nil

        if child.parent == nil
            raise "ERROR!"
        end
    end

    attr_reader :value, :parent, :children
end
