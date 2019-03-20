#ruby lib/pieces_classes.rb

class Pawn
  attr_accessor :piece, :color, :position

  def initialize color, position
    @piece = :pawn
    @color = color
    @position = position
  end
  def possible_moves
    possible = []
    if color == :white
      if (@position[0] >= 0 && @position[0] < 7)
        possible << [@position[0]+1, @position[1]]
      end
    else
      if (@position[0] > 0 && @position[0] <= 7)
        possible << [@position[0]-1, @position[1]]
      end
    end
    possible
  end
end

pawn = Pawn.new :white, [1,1]
puts pawn.piece