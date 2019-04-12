require_relative "00_tree_node.rb"
class KnightPathFinder

    attr_reader :chess_board, :root_node
    
    def initialize(start_pos)
        @start_pos = start_pos
        @chess_board = Array.new(8) {Array.new(8) } 
        @root_node = Node.new(start_pos)  
        @considered_positions = [pos]
    end

    # def [](pos)
    #     x, y = pos
    #     @chess_board[x][y]
    # end

    # def []=(pos, value)
    #     x, y = pos
    #     @chess_board[x][y] = value
    # end

    def self.valid_moves(pos)
        moves = []
        x, y = pos

        possible_movements = [[2,-1],[2,1],[-2,-1],[-2,1],[-1,2],[-1,-2],[1,2],[1,-2]]
        possible_movements.each do |movement|
            new_move = x + movement[0], y + movement[1] 
            moves << new_move
        end

        range = (0..7).to_a
        valid_moves = moves.select do |move|
            range.include?(move[0]) && range.include?(move[1])
        end
        
        valid_moves
    end

    def new_move_positions(pos)
        valid = KnightPathFinder.valid_moves(pos)
        
        the_moves = valid.select { |move| !@considered_positions.include?(move) }

        @considered_positions.concat(the_moves)

        return the_moves
    end

    def build_move_tree
        queue = [self.root_node]

        until queue.empty?
            current_node = queue.shift
            moves = new_move_positions(current_node.value)
            moves.each do |move|
                new_node = Node.new(move)
                new_node.parent = current_node
                queue << new_node
            end
        end
    end

    def find_path(end_pos)
        root = self.root_node

        root.dfs(end_pos)
    end

    def trace_path_back(node)
        traced_nodes = []
        
        until node.parent == nil
            traced_nodes << node.value 
            parent = node.parent
            trace_path_back(parent)
        end
        
    end 
end