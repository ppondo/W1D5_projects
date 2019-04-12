require "byebug"
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
            raise "ERROR@^%!@^&!@#!"
        end
    end

    def dfs(target)
        return nil if self.nil?
        return self if self.value == target

        self.children.each do |child|
            # debugger
            search_result = child.dfs(target)
            # debugger
            return search_result unless search_result.nil?
        end

        nil
    end

    def bfs(target)
        queue = [self]

        until queue.empty?
            el = queue.shift
            if el.value == target 
                return el 
            else
                el.children.each { |child| queue << child }
            end
        end

    end

    attr_reader :value, :parent, :children
end
