require_relative "0_polytree_node"

class KnightPathFinder
    def self.valid_moves(pos, board_size = 8)
        # Assuming an 8x8 board
        row, col = pos
        move_candidates = []
        (0..row + 2).each do |x|
            next unless x < board_size
            (0..col + 2).each do |y|
                next unless y < board_size
                deltax = (x - row).abs
                deltay = (y - col).abs
                valid = (deltax == 2 && deltay == 1) || (deltax == 1 && deltay == 2)
                move_candidates << [x,y] if valid
            end
        end
        move_candidates
    end

    def initialize(startpos)
        @root_node = PolyTreeNode.new(startpos)
        @considered_positions = [startpos]
        self.build_move_tree
    end

    attr_reader :root_node

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos)
            .reject { |candidate| @considered_positions.include?(candidate) }
            .each { |move| @considered_positions << move }
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            focus = queue.shift
            new_moves = new_move_positions(focus.value)
            new_moves.each do |move|
                child_node = PolyTreeNode.new(move)
                focus.add_child(child_node)
                queue << child_node
            end
        end
    end

    def find_path

    end
end