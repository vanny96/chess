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
    if color == :white
      if (@position[0] >= 0 && @position[0] < 7) &&
          parent.grid[@position[0]+1][@position[1]].color.nil?

        possible << [@position[0]+1, @position[1]]
      end
    else
      if (@position[0] > 0 && @position[0] <= 7) &&
        parent.grid[@position[0]-1][@position[1]].color.nil?

        possible << [@position[0]-1, @position[1]]
      end
    end
    possible
  end
end

