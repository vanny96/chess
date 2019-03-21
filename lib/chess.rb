require_relative 'pieces_classes'
#ruby lib/chess.rb

class Chess
  attr_accessor :grid

  def initialize
    
  end

  def empty_grid
    grid = []
    for i in 0..7
      row = []
      for j in 0..7
        row << VoidPiece.new([i,j])
      end
      grid << row
    end
    grid
  end
end

pawn = Pawn.new :black, [1,1]

game = Chess.new
game.empty_grid.each do |row|
  row.each do |cell|
    print cell.position
  end
end