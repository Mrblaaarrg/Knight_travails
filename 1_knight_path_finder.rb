require_relative "0_polytree_node"

class KnightPathFinder
    def self.valid_moves(pos)
        row, col = pos
        move_candidates = []
        (0..row + 2).each do |x|
            (0..col + 2).each do |y|
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

    def new_move_positions(pos)
        valid_candidates = KnightPathFinder.valid_moves(pos)
        new_moves = valid_candidates.reject { |candidate| @considered_positions.include?(candidate) }
        new_moves.each { |move| @considered_positions << move }
        new_moves
    end

    def build_move_tree

    end

    def find_path

    end
end