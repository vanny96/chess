#ruby lib/pieces_classes.rb

class Pawn
  attr_accessor :piece, :color, :position

  def initialize color, position
    @piece = :pawn
    @color = color
    @position = position
  end
end

pawn = Pawn.new :white, [1,1]
puts pawn.piece