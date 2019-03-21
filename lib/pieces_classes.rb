#ruby lib/pieces_classes.rb
class VoidPiece
  attr_accessor :piece, :position, :color, :parent

  def initialize position, parent=nil
    @piece = :empty
    @color = nil
    @position = position
    @parent = parent
  end
end

class Pawn
  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :pawn
    @color = color
    @position = position
    @parent = parent
  end
  def possible_moves
    possible = []

    #check possible moves ahead, on the left and then on the right
    if color == :white
      
      unless check_edges[:top]
        if parent.grid[@position[0]+1][@position[1]].color.nil?

          possible << [@position[0]+1, @position[1]]
        end
        if !check_edges[:left] &&
            parent.grid[@position[0]+1][@position[1] - 1].color == :black

            possible << [@position[0]+1, @position[1] - 1]
        end
        if !check_edges[:right] &&
          parent.grid[@position[0]+1][@position[1] + 1].color == :black

          possible << [@position[0]+1, @position[1] + 1]
        end
      end

    else
      unless check_edges[:bottom]

        if parent.grid[@position[0]-1][@position[1]].color.nil?

          possible << [@position[0]-1, @position[1]]
        end
        if !check_edges[:left] &&
          parent.grid[@position[0]-1][@position[1] - 1].color == :white

          possible << [@position[0]-1, @position[1] - 1]
        end
        if !check_edges[:right] &&
          parent.grid[@position[0]-1][@position[1] + 1].color == :white

          possible << [@position[0]-1, @position[1] + 1]
        end
      end
    end

    possible
  end

  private
  def check_edges
    edges = {top: false, right: false, bottom: false, left: false}
    edges[:top] = true if @position[0] == 7
    edges[:bottom] = true if @position[0] == 0
    edges[:right] = true if @position[1] == 7
    edges[:left] = true if @position[1] == 0
    edges
  end
end

