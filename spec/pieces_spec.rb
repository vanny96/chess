require './lib/pieces_classes.rb'

describe Pawn do
  describe "#possible_moves" do
    it "Suggests moves forwards if it's white" do
      pawn = Pawn.new :white, [1,1]
      expect(pawn.possible_moves).to eql([[2,1]]) 
    end
    it "Suggests moves backwards if it's black" do
      pawn = Pawn.new :black, [1,1]
      expect(pawn.possible_moves).to eql([[0,1]])
    end
    it "Doesn't suggest anything if against the wall" do
      pawn = Pawn.new :white, [7,2]
      expect(pawn.possible_moves).to eql([])
    end
  end
end