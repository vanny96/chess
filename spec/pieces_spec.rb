require './lib/pieces_classes.rb'

describe Pawn do
  describe "#possible_moves" do
    it "Suggests moves forwards if it's white" do
      pawn = Pawn.new :white, [1,1]
      expect(pawn.possible_moves).to eql([[2,1]]) 
    end
  end
end